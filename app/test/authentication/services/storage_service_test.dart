import 'package:countries_app/src/authentication/services/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SharedPreferencesService', () {
    late SharedPreferencesService service;

    const key = 'test_key';
    const notFoundKey = 'not_found_key';
    const value = 'test_value';

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        key: value,
      });

      service = SharedPreferencesService();
    });

    test(
        'write() should call SharedPreferencesService.write with correct key and value',
        () async {
      // Act
      final result = await service.write(key, value);

      // Assert
      expect(result, true);
    });

    test('read() should call SharedPreferencesService.read with correct key',
        () async {
      // Act
      final result = await service.read(key);

      // Assert
      expect(result, value);
    });

    test(
        'read() should return null if key is not found in SharedPreferencesService',
        () async {
      // Act
      final result = await service.read(notFoundKey);

      // Assert
      expect(result, null);
    });

    test(
        'remove() should call SharedPreferencesService.remove with correct key',
        () async {
      // Act
      final result = await service.remove(key);

      // Assert
      expect(result, true);
    });

    test(
        'remove() should return false if key is not found in SharedPreferencesService',
        () async {
      // Act
      final result = await service.remove(notFoundKey);

      // Assert
      expect(result, false);
    });
  });
}
