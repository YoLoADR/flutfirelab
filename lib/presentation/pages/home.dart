import 'package:flutfirelab/data/firestore_service.dart';
import 'package:flutfirelab/data/model/note.dart';
import 'package:flutfirelab/presentation/pages/note_details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
        ),
        body: StreamBuilder(
          stream: FirestoreService().getNotes(),
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Note note = snapshot.data[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.description),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteDetailsPage(note: note),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}