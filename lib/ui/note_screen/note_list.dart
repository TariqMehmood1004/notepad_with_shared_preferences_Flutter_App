// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad/bloc/note/note_bloc.dart';
import 'package:notepad/bloc/note/note_state.dart';
import 'package:notepad/models/note_model.dart';

class NoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NotesLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.date.toString()),
                  trailing: Checkbox(
                    value: note.isCompleted,
                    onChanged: (value) {
                      BlocProvider.of<NoteBloc>(context).add(UpdateNote(
                        note.copyWith(isCompleted: value ?? false),
                      ));
                    },
                  ),
                  onLongPress: () {
                    BlocProvider.of<NoteBloc>(context).add(DeleteNote(note));
                  },
                );
              },
            );
          } else if (state is NoteError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddNoteDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddNoteDialog extends StatefulWidget {
  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitial) {
          return AlertDialog(
            title: Text('Add Note'),
            content: TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty) {
                    NoteModel note = NoteModel(
                        title: _titleController.text,
                        date: DateTime.now(),
                        isCompleted: false);
                    BlocProvider.of<NoteBloc>(context).add(AddNote(note));
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add'),
              ),
            ],
          );
        } else {
          return Container(); // Return an empty container while the state is loading or in an error state
        }
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
