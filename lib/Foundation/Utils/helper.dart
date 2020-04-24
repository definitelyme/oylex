import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

String randomString(int length) {
  var random = Random();
  var charCodes = List.generate(length, (index) => random.nextInt(33) + 89);
  return String.fromCharCodes(charCodes);
}

// ignore: non_constant_identifier_names
dynamic read_PageState(BuildContext context, dynamic key) => PageStorage.of(context).readState(context, identifier: key);

// ignore: non_constant_identifier_names
void writeTo_PageState(BuildContext context, dynamic key, dynamic value) => PageStorage.of(context).writeState(
      context,
      value,
      identifier: key,
    );

dynamic readSharedPreference(String key, SHARED_PREF_TYPE type) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  switch (type) {
    case SHARED_PREF_TYPE.INT:
      return preferences.getInt(key);
    case SHARED_PREF_TYPE.BOOL:
      return preferences.getBool(key);
    case SHARED_PREF_TYPE.STRING:
      return preferences.getString(key);
    case SHARED_PREF_TYPE.DOUBLE:
      return preferences.getDouble(key);
    case SHARED_PREF_TYPE.STRING_LIST:
      return preferences.getStringList(key);
  }
}

void writeSharedPreference(String key, dynamic value, SHARED_PREF_TYPE type) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  switch (type) {
    case SHARED_PREF_TYPE.INT:
      preferences.setInt(key, value);
      break;
    case SHARED_PREF_TYPE.BOOL:
      preferences.setBool(key, value);
      break;
    case SHARED_PREF_TYPE.STRING:
      preferences.setString(key, value);
      break;
    case SHARED_PREF_TYPE.DOUBLE:
      preferences.setDouble(key, value);
      break;
    case SHARED_PREF_TYPE.STRING_LIST:
      preferences.setStringList(key, value);
      break;
  }
}

void precacheLocalImages(BuildContext context) {
  precacheImage(AssetImage("$IMAGES_FOLDER/laravel-2.jpg"), context);
  precacheImage(AssetImage("$IMAGES_FOLDER/knowledge-03.jpg"), context);
  precacheImage(AssetImage("$IMAGES_FOLDER/knowledge-07.jpg"), context);
}

enum SHARED_PREF_TYPE {
  INT,
  BOOL,
  STRING,
  DOUBLE,
  STRING_LIST,
}

enum SCROLL_STATE { TRUE, FALSE }
