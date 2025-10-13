import UserNotifications
import CryptoKit

/// Notification Service Extension for decrypting push notifications
class NotificationService: UNNotificationServiceExtension {

    /// App Group identifier constructed from the bundle identifier
    /// Convention: "group.{BUNDLE_ID}"
    /// Example: If bundle ID is "com.yourcompany.yourapp", App Group will be "group.com.yourcompany.yourapp"
    private var appGroupIdentifier: String {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            NSLog("NativePush: Bundle identifier not found")
            return "group.unknown"
        }
        // Remove the notification service extension suffix if present
        let suffix = ".NotificationService"
        let mainBundleId = bundleIdentifier.hasSuffix(suffix)
            ? String(bundleIdentifier.dropLast(suffix.count))
            : bundleIdentifier
        return "group.\(mainBundleId)"
    }

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        guard let bestAttemptContent = bestAttemptContent else {
            NSLog("NativePush: Failed to create mutable content")
            contentHandler(request.content)
            return
        }

        // Get encrypted data and nonce from notification payload
        guard let userInfo = request.content.userInfo as? [String: Any] else {
            NSLog("NativePush: User info is not a dictionary")
            contentHandler(bestAttemptContent)
            return
        }

        guard let encryptedBase64 = userInfo["encrypted"] as? String else {
            NSLog("NativePush: No 'encrypted' field in payload")
            contentHandler(bestAttemptContent)
            return
        }

        guard let nonceBase64 = userInfo["nonce"] as? String else {
            NSLog("NativePush: No 'nonce' field in payload")
            contentHandler(bestAttemptContent)
            return
        }

        // Decrypt the notification
        if let (title, body) = decryptNotification(encrypted: encryptedBase64, nonce: nonceBase64) {
            bestAttemptContent.title = title
            if let body = body {
                bestAttemptContent.body = body
            }
        } else {
            // Decryption failed
            NSLog("NativePush: Decryption failed")
            bestAttemptContent.title = "Notification decrypting failed"
            bestAttemptContent.body = ""
        }

        contentHandler(bestAttemptContent)
    }

    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content,
        // otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

    /// Decrypts the notification payload using AES-GCM
    ///
    /// - Parameters:
    ///   - encrypted: Base64-encoded encrypted data
    ///   - nonce: Base64-encoded nonce
    /// - Returns: Tuple of (title, body) if decryption succeeds, nil otherwise
    private func decryptNotification(encrypted: String, nonce: String) -> (String, String?)? {
        // Read encryption key from shared App Group container
        guard let fileURL = getEncryptionKeyFileURL() else {
            NSLog("NativePush: Failed to get encryption key file URL")
            return nil
        }

        guard let encryptionKeyBase64 = try? String(contentsOf: fileURL, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines) else {
            NSLog("NativePush: Failed to read encryption key file at %@", fileURL.path)
            return nil
        }

        guard let encryptionKeyData = Data(base64Encoded: encryptionKeyBase64) else {
            NSLog("NativePush: Failed to decode encryption key from base64")
            return nil
        }

        guard let encryptedData = Data(base64Encoded: encrypted) else {
            NSLog("NativePush: Failed to decode encrypted data from base64")
            return nil
        }

        guard let nonceData = Data(base64Encoded: nonce) else {
            NSLog("NativePush: Failed to decode nonce from base64")
            return nil
        }

        // Decrypt using AES-GCM (requires iOS 13+)
        guard let decryptedData = aesGCMDecrypt(data: encryptedData, key: encryptionKeyData, nonce: nonceData) else {
            return nil
        }

        // Parse JSON
        guard let json = try? JSONSerialization.jsonObject(with: decryptedData) as? [String: Any] else {
            NSLog("NativePush: Failed to parse decrypted JSON")
            return nil
        }

        guard let title = json["title"] as? String else {
            NSLog("NativePush: No 'title' field in decrypted JSON")
            return nil
        }

        let body = json["body"] as? String
        return (title, body)
    }

    /// Gets the URL for the encryption key file in the App Group container
    ///
    /// - Returns: URL to the encryption key file, or nil if not accessible
    private func getEncryptionKeyFileURL() -> URL? {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier) else {
            NSLog("NativePush: Failed to get App Group container for: %@", appGroupIdentifier)
            return nil
        }
        return containerURL.appendingPathComponent("native_push_encryption_key.txt")
    }

    /// Decrypts data using AES-GCM
    ///
    /// - Parameters:
    ///   - data: Encrypted data (ciphertext + 16-byte authentication tag)
    ///   - key: Encryption key (16 bytes for AES-128)
    ///   - nonce: Nonce/IV for AES-GCM
    /// - Returns: Decrypted data, or nil if decryption fails
    private func aesGCMDecrypt(data: Data, key: Data, nonce: Data) -> Data? {
        if #available(iOS 13.0, *) {
            do {
                let symmetricKey = SymmetricKey(data: key)

                // AES-GCM authentication tag is the last 16 bytes
                let tagSize = 16
                guard data.count > tagSize else {
                    NSLog("NativePush: Encrypted data too short (needs at least %d bytes)", tagSize + 1)
                    return nil
                }

                let ciphertext = data.prefix(data.count - tagSize)
                let tag = data.suffix(tagSize)

                let sealedBox = try AES.GCM.SealedBox(
                    nonce: AES.GCM.Nonce(data: nonce),
                    ciphertext: ciphertext,
                    tag: tag
                )

                return try AES.GCM.open(sealedBox, using: symmetricKey)
            } catch {
                NSLog("NativePush: AES-GCM decryption error: %@", error.localizedDescription)
                return nil
            }
        } else {
            NSLog("NativePush: iOS 13+ required for AES-GCM")
            return nil
        }
    }
}
