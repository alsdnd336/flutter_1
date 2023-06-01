import 'package:flutter/material.dart';
import 'package:untitled1/page/note_edit_page.dart';
import 'package:untitled1/page/note_list_page.dart';
import 'package:untitled1/page/note_view_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticky Notes',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        NoteListPage.routeName: (context) => NoteListPage(),
        NoteEditPage.routeName: (context) {
          final age = ModalRoute.of(context)!.settings.arguments;
          final index = age != null ? age as int : null;
          return NoteEditPage(index);
        },
        NoteViewPage.routeName: (context) {
          final noteIndex = ModalRoute.of(context)!.settings.arguments as int;
          return NoteViewPage(noteIndex);
        },
      });
  }
}
