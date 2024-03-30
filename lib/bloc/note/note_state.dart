import 'package:notepad/models/note_model.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NotesLoaded extends NoteState {
  final List<NoteModel> notes;

  NotesLoaded(this.notes);
}

class NoteError extends NoteState {
  final String message;

  NoteError(this.message);
}
