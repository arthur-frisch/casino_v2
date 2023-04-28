import 'package:casino_v2/models/token_storage.dart';
import 'package:flutter/material.dart';

class TokenModel extends ChangeNotifier {
  StorageService _storageService = StorageService();

  StorageService get storageService => _storageService;

  set storageService(StorageService value) {
    if (value != _storageService) {
      _storageService = value;
      notifyListeners();
    }
  }
}