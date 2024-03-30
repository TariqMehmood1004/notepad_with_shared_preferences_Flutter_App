import './utils/apis.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'VikVok',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(),
      home: const HomePage(),
    ),
  );
}
