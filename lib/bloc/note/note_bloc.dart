// ignore_for_file: override_on_non_overriding_member

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:notepad/bloc/note/note_state.dart';
import 'package:notepad/models/note_model.dart';
import 'package:notepad/services/note_storage_service.dart';
part 'note_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteService noteService;

  NoteBloc({required this.noteService}) : super(NoteInitial()) {
    on<LoadNotes>((event, emit) async {
      try {
        List<NoteModel> notes = await noteService.loadNotes();
        emit(NotesLoaded(notes));
      } catch (e) {
        emit(NoteError("Failed to load notes: $e"));
      }
    });
  }

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is LoadNotes) {
      yield* _mapLoadNotesToState();
    } else if (event is AddNote) {
      yield* _mapAddNoteToState(event);
    } else if (event is UpdateNote) {
      yield* _mapUpdateNoteToState(event);
    } else if (event is DeleteNote) {
      yield* _mapDeleteNoteToState(event);
    }
  }

  Stream<NoteState> _mapLoadNotesToState() async* {
    try {
      List<NoteModel> notes = await noteService.loadNotes();
      yield NotesLoaded(notes);
    } catch (e) {
      yield NoteError("Failed to load notes: $e");
    }
  }

  Stream<NoteState> _mapAddNoteToState(AddNote event) async* {
    try {
      List<NoteModel> notes = await noteService.addNote(event.note);
      yield NotesLoaded(notes);
    } catch (e) {
      yield NoteError("Failed to add note: $e");
    }
  }

  Stream<NoteState> _mapUpdateNoteToState(UpdateNote event) async* {
    try {
      List<NoteModel> notes = await noteService.updateNote(event.note);
      yield NotesLoaded(notes);
    } catch (e) {
      yield NoteError("Failed to update note: $e");
    }
  }

  Stream<NoteState> _mapDeleteNoteToState(DeleteNote event) async* {
    try {
      List<NoteModel> notes = await noteService.deleteNote(event.note);
      yield NotesLoaded(notes);
    } catch (e) {
      yield NoteError("Failed to delete note: $e");
    }
  }
}
