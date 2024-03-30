import 'package:notepad/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NoteService {
  static const String _key = 'notes';

  Future<List<NoteModel>> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_key);
    if (jsonList == null) {
      return [];
    }
    return jsonList
        .map((jsonString) => NoteModel.fromJson(json.decode(jsonString)))
        .toList();
  }

  Future<List<NoteModel>> addNote(NoteModel note) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList(_key) ?? [];
    jsonList.add(json.encode(note.toJson()));
    await prefs.setStringList(_key, jsonList);
    return loadNotes();
  }

  Future<List<NoteModel>> updateNote(NoteModel note) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList(_key) ?? [];
    int index = jsonList.indexWhere((jsonString) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return jsonMap['title'] == note.title;
    });
    if (index != -1) {
      jsonList[index] = json.encode(note.toJson());
      await prefs.setStringList(_key, jsonList);
    }
    return loadNotes();
  }

  Future<List<NoteModel>> deleteNote(NoteModel note) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList(_key) ?? [];
    jsonList.removeWhere((jsonString) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return jsonMap['title'] == note.title;
    });
    await prefs.setStringList(_key, jsonList);
    return loadNotes();
  }
}
