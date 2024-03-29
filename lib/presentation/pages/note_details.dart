import 'package:flutfirelab/data/model/note.dart';
import 'package:flutter/material.dart';

class NoteDetailsPage extends StatelessWidget {
  final Note note;

  const NoteDetailsPage({Key key, @required this.note}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(note.title, style: Theme.of(context)
            .textTheme.title.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),),
            const SizedBox(height: 20.0),
            Text(note.description, style: TextStyle(
              fontSize: 16.0))
          ],
        ),
      )
    );
  }
}