import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/core/failures/store_failure.dart';
import 'package:taxi_app/core/store/store.dart';

class StorePreference extends Store {
  static late SharedPreferences _prefs;

  static create() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Either<StoreFailure, T> read<T>(String key) {
    try {
      if (_prefs.containsKey(key)) {
        String? jsonString = _prefs.getString(key);
        if (jsonString != null) {
          T value = jsonDecode(jsonString) as T;
          return right(value);
        } else {
          return left(
            StoreFailure(
              error: kDebugMode ? "No value found for key: $key" : "No Data",
            ),
          );
        }
      } else {
        return left(
          StoreFailure(
            error: kDebugMode ? "No value found for key: $key" : "No Data",
          ),
        );
      }
    } catch (e) {
      return left(StoreFailure(error: e.toString()));
    }
  }

  @override
  Either<StoreFailure, T> write<T>(String key, T value) {
    try {
      _prefs.setString(key, jsonEncode(value));
      return right(value);
    } catch (e) {
      return left(StoreFailure(error: e.toString()));
    }
  }

  @override
  Either<StoreFailure, bool> delete<T>(String key) {
    try {
      _prefs.remove(key);
      return right(true);
    } catch (e) {
      return left(StoreFailure(error: e.toString()));
    }
  }
}
