import 'package:app/utils/email_address_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validator = EmailAddressValidator();

  group('EmailAddressValidator.valid emails', () {
    test('accepts a standard address', () {
      expect(validator.validate('user@example.com'), isNull);
    });

    test('accepts a subdomain', () {
      expect(validator.validate('user@mail.example.com'), isNull);
    });

    test('accepts allowed characters in local part', () {
      expect(validator.validate('user.name@example.com'), isNull);
      expect(validator.validate('user_name@example.com'), isNull);
      expect(validator.validate('user-name@example.com'), isNull);
      expect(validator.validate('user123@example.com'), isNull);
    });

    test('trims surrounding whitespace', () {
      expect(validator.validate('  user@example.com  '), isNull);
    });

    test('accepts a single-letter local and domain parts', () {
      expect(validator.validate('a@b.c'), isNull);
    });
  });

  group('EmailAddressValidator.invalid emails', () {
    test('rejects an empty string', () {
      expect(validator.validate(''), equals(EmailAddressValidationError.empty));
    });

    test('rejects an address with multiple @ signs', () {
      expect(validator.validate('a@b@c.com'), equals(EmailAddressValidationError.multipleAtSigns));
    });

    test('rejects whitespace inside the address', () {
      expect(
        validator.validate('user name@example.com'),
        equals(EmailAddressValidationError.containsWhitespace),
      );
      expect(
        validator.validate('user@exa mple.com'),
        equals(EmailAddressValidationError.containsWhitespace),
      );
    });

    test('rejects an address without an @ sign', () {
      expect(validator.validate('ab.com'), equals(EmailAddressValidationError.multipleAtSigns));
    });

    test('rejects an empty or non-alphanumeric-only local part', () {
      expect(
        validator.validate('@example.com'),
        equals(EmailAddressValidationError.invalidCharacters),
      );
      expect(
        validator.validate('!@example.com'),
        equals(EmailAddressValidationError.invalidCharacters),
      );
      expect(
        validator.validate('us!er@example.com'),
        equals(EmailAddressValidationError.invalidCharacters),
      );
    });

    test('rejects a local part with no alphanumeric characters', () {
      expect(
        validator.validate('---@example.com'),
        equals(EmailAddressValidationError.missingAlphanumeric),
      );
    });

    test('rejects invalid characters in the local part', () {
      expect(
        validator.validate('us!er@example.com'),
        equals(EmailAddressValidationError.invalidCharacters),
      );
      expect(
        validator.validate('user+tag@example.com'),
        equals(EmailAddressValidationError.invalidCharacters),
      );
    });

    test('rejects consecutive dots in local and domain parts', () {
      expect(
        validator.validate('user..name@example.com'),
        equals(EmailAddressValidationError.consecutiveDots),
      );
      expect(
        validator.validate('user@example..com'),
        equals(EmailAddressValidationError.consecutiveDots),
      );
    });

    test('rejects a local part with leading or trailing dot', () {
      expect(
        validator.validate('.user@example.com'),
        equals(EmailAddressValidationError.localPartLeadingOrTrailingDot),
      );
      expect(
        validator.validate('user.@example.com'),
        equals(EmailAddressValidationError.localPartLeadingOrTrailingDot),
      );
    });

    test('rejects a domain part with leading or trailing dot', () {
      expect(
        validator.validate('user@.example.com'),
        equals(EmailAddressValidationError.domainLeadingOrTrailingDot),
      );
      expect(
        validator.validate('user@example.com.'),
        equals(EmailAddressValidationError.domainLeadingOrTrailingDot),
      );
    });

    test('rejects a domain without a dot', () {
      expect(
        validator.validate('user@example'),
        equals(EmailAddressValidationError.domainMissingDot),
      );
      expect(validator.validate('user@com'), equals(EmailAddressValidationError.domainMissingDot));
    });
  });
}
