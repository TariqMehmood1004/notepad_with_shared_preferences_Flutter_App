// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad/bloc/note/note_bloc.dart';
import 'package:notepad/ui/note_screen/note_list.dart';
import './utils/apis.dart';

void main() {
  final NoteService noteService = NoteService();
  runApp(MyApp(noteService: noteService));
}

class MyApp extends StatelessWidget {
  final NoteService noteService;

  const MyApp({required this.noteService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(
            create: (context) => NoteBloc(noteService: noteService)),
      ],
      child: MaterialApp(
        title: 'NotePad',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(
            color: kPrimary,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
            actionsIconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
          ),
          scaffoldBackgroundColor: kPrimary,
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.black),
            bodyText1: TextStyle(color: Colors.black),
            headline6: TextStyle(color: Colors.black),
            headline5: TextStyle(color: Colors.black),
            headline4: TextStyle(color: Colors.black),
            headline3: TextStyle(color: Colors.black),
            headline2: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          bottomAppBarTheme: BottomAppBarTheme(color: kPrimary),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: kPrimary,
            selectedItemColor: kViolet,
            unselectedItemColor: kUnselectedItemColor,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        darkTheme: ThemeData.light(),
        themeMode: ThemeMode.light,
        home: NoteListPage(),
      ),
    );
  }
}
