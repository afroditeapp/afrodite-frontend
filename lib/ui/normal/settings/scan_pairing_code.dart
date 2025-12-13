import 'dart:convert';
import 'dart:typed_data';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

Future<String?> openScanPairingCodeScreen(BuildContext context) {
  return MyNavigator.push(context, ScanPairingCodePage());
}

class ScanPairingCodePage extends MyScreenPage<String> {
  ScanPairingCodePage() : super(builder: (closer) => ScanPairingCodeScreen(closer: closer));
}

class ScanPairingCodeScreen extends StatefulWidget {
  final PageCloser<String> closer;
  const ScanPairingCodeScreen({required this.closer, super.key});

  @override
  State<ScanPairingCodeScreen> createState() => _ScanPairingCodeScreenState();
}

class _ScanPairingCodeScreenState extends State<ScanPairingCodeScreen> {
  final MobileScannerController _controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );
  bool _qrCodeDetected = false;

  @override
  void initState() {
    super.initState();
    MobileScannerPlatform.instance.setBarcodeLibraryScriptUrl("zxing.js");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _parsePairingCode(Uint8List rawBytes) {
    try {
      // QR code format: version (1 byte) + SHA256 hash (32 bytes) = 33 bytes total
      if (rawBytes.length != 33) {
        return null;
      }

      // Check version
      final version = rawBytes[0];
      if (version != 1) {
        return null;
      }

      // Extract hash bytes (bytes 1-32)
      final hashBytes = rawBytes.sublist(1, 33);

      // Convert to base64url string
      final base64UrlString = base64UrlEncode(hashBytes);

      return "1$base64UrlString";
    } catch (e) {
      return null;
    }
  }

  void _onDetect(BarcodeCapture capture) {
    if (_qrCodeDetected) return;

    final List<Barcode> barcodes = capture.barcodes;

    for (final barcode in barcodes) {
      final rawBytes = barcode.rawBytes;
      if (rawBytes != null) {
        final pairingCode = _parsePairingCode(rawBytes);
        if (pairingCode != null) {
          _qrCodeDetected = true;

          // Return the pairing code to the previous screen
          widget.closer.close(context, pairingCode);
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.scan_pairing_code_screen_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => _controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect, tapToFocus: true),
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                context.strings.scan_pairing_code_instruction,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
