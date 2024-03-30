part of 'note_bloc.dart';

abstract class NoteEvent {}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final NoteModel note;

  AddNote(this.note);
}

class UpdateNote extends NoteEvent {
  final NoteModel note;

  UpdateNote(this.note);
}

class DeleteNote extends NoteEvent {
  final NoteModel note;

  DeleteNote(this.note);
}
