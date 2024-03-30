import './utils/apis.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Notepad',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.light(),
      theme: ThemeData(),
      home: const MyApp(),
    ),
  );
}
