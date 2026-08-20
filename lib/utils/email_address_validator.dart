/// What is wrong with an email address.
enum EmailAddressValidationError {
  empty,
  containsWhitespace,
  multipleAtSigns,
  invalidCharacters,
  missingAlphanumeric,
  consecutiveDots,
  localPartLeadingOrTrailingDot,
  domainLeadingOrTrailingDot,
  domainMissingDot,
}

/// Validates email addresses during registration.
class EmailAddressValidator {
  const EmailAddressValidator();

  /// Returns the reason why [email] is invalid, or `null` if it is valid.
  EmailAddressValidationError? validate(String email) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      return EmailAddressValidationError.empty;
    }
    // No whitespace allowed anywhere in the address.
    if (RegExp(r'\s').hasMatch(trimmed)) {
      return EmailAddressValidationError.containsWhitespace;
    }

    // Only a single `@` is allowed.
    final parts = trimmed.split('@');
    if (parts.length != 2) {
      return EmailAddressValidationError.multipleAtSigns;
    }

    final localPart = parts[0];
    final domainPart = parts[1];

    // Every character of the local part must be allowed. `+` is excluded as
    // the backend does not support address aliases.
    if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(localPart)) {
      return EmailAddressValidationError.invalidCharacters;
    }

    // The local part must contain at least one alphanumeric character.
    if (!RegExp(r'[a-zA-Z0-9]').hasMatch(localPart)) {
      return EmailAddressValidationError.missingAlphanumeric;
    }

    // Subsequent dots are not allowed.
    if (localPart.contains('..') || domainPart.contains('..')) {
      return EmailAddressValidationError.consecutiveDots;
    }

    // Local part must not start or end with a dot.
    if (localPart.startsWith('.') || localPart.endsWith('.')) {
      return EmailAddressValidationError.localPartLeadingOrTrailingDot;
    }

    // Domain part must not start or end with a dot and must contain a dot (TLD).
    if (domainPart.startsWith('.') || domainPart.endsWith('.')) {
      return EmailAddressValidationError.domainLeadingOrTrailingDot;
    }
    if (!domainPart.contains('.')) {
      return EmailAddressValidationError.domainMissingDot;
    }

    return null;
  }
}
