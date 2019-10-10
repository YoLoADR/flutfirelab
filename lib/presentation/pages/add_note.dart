import 'package:flutfirelab/data/firestore_service.dart';
import 'package:flutfirelab/data/model/note.dart';
import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  // ajouter un paramètre
  final Note note;
  // constructor
  const AddNotePage({Key key, this.note}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  FocusNode _descriptionNode;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: isEditeNote ? widget.note.title : '');
    _descriptionController =
        TextEditingController(text: isEditeNote ? widget.note.description : '');
    _descriptionNode = FocusNode();
  }

  get isEditeNote => widget.note != null;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditeNote ? 'Update Note' : 'Add Note'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_descriptionNode);
                  },
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title can not be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  focusNode: _descriptionNode,
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description can not be empty";
                    }
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text(isEditeNote ? 'Update' : 'Save'),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      try {
                        if (isEditeNote) {
                          Note note = Note(
                              description: _descriptionController.text,
                              title: _titleController.text,
                              id: widget.note.id
                              );
                          await FirestoreService().updateNote(note);
                        } else {
                          Note note = Note(
                              description: _descriptionController.text,
                              title: _titleController.text
                              );
                          await FirestoreService().addNote(note);
                        }
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
