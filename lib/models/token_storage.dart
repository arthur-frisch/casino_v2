import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageItem {
 StorageItem(this.key, this.value);

 final String key;
 final String value;
}

class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
   );

  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(
      key: newItem.key, value: newItem.value, aOptions: _getAndroidOptions());
  }

  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future<Map<String, String>> readAll() async {
    return await _secureStorage.readAll(aOptions: _getAndroidOptions());
  }
}