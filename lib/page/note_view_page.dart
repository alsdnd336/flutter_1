import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/page/note_edit_page.dart';
import 'package:untitled1/providers.dart';

class NoteViewPage extends StatefulWidget {
  static const routeName = "/view";

  final int index;

  NoteViewPage(this.index);

  @override
  State createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {

  @override
  Widget build(BuildContext context) {
    final note = noteManager().getNote(widget.index);
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
              onPressed: () => _eidtPage(widget.index),
              icon: Icon(Icons.edit),
              tooltip: '편집',),
          IconButton(
              onPressed: () => _deletePage(widget.index),
              icon: Icon(Icons.delete),
              tooltip: '삭제',),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: note.color,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8.0),
            child: Text(note.body),
          ),
        ),
      ),
    );
  }

  void _eidtPage(int index){
    Navigator.pushNamed(
        context,
        NoteEditPage.routeName,
        arguments: index,
    ).then((_) {
      setState(() {});
    });
  }

  void _deletePage(int index){
    showDialog(
        context: context,
        builder: (context){
          final index = widget.index;
          return AlertDialog(
            title: Text('삭제'),
            content: Text('노트를 삭제하시겠습니까??'),
            actions: [
              TextButton(
                child: Text('삭제하기'),
                onPressed: (){
                  final note = noteManager().deleteNote(index);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              TextButton(
                child: Text('취소'),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
        );
  }
}