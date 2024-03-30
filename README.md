# Notepad Flutter App

## Features
- Create, edit, and delete notes
- Save notes using shared preferences
- Simple and intuitive user interface

## Technologies Used
- Flutter
- Shared Preferences package

## How to Use
1. Install the app on your device.
2. Open the app and start creating notes.
3. Your notes will be saved automatically using shared preferences.

## Code Snippet
```dart
// Example code to save and retrieve data using shared preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveData(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> getData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
