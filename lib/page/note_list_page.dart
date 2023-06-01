import 'package:flutter/material.dart';
import 'package:untitled1/data/note.dart';
import 'package:untitled1/providers.dart';

import 'note_edit_page.dart';
import 'note_view_page.dart';

class NoteListPage extends StatefulWidget {
  static const routeName = '/';

  @override
  State createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sticky Notes'),
      ),
      body: GridView(
        children: _buildCards(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NoteEditPage.routeName).then((value) {
           setState(() {});
          });
        },
        tooltip: '노트 추가',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildCards() {
    final notes = noteManager().listNotes();

    return List.generate(notes.length
        , (int index) => _buildCard(index, notes[index]));
  }

  Widget _buildCard(int index ,Note note) {
    return InkWell(
      child: Card(
        color: note.color,
        child: Padding(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title.isEmpty ? '(제목 없음)' : note.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Text(
                  note.body,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          padding: EdgeInsets.all(12.0),
        ),
      ),
      onTap: () => _gotoView(index),
    );
  }

  void _gotoView(int index) async {
    await Navigator.pushNamed(context, NoteViewPage.routeName, arguments: index);
    setState(() {}); // 공부

  }
}
