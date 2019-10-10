import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutfirelab/data/model/note.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  //A chaque fois qu'on fait appel à FirestoreService on fait appel à cette instance (Singleton)
  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Note>> getNotes() {
    return _db
        .collection('note')
        .snapshots()
        .map((snapshot) => snapshot.documents.map(
              (doc) => Note.fromMap(doc.data, doc.documentID),
            ).toList(),
            );
  }

  Future<void> addNote(Note note){
    return _db
    .collection('note')
    .add(note.toMap());
  }

  Future<void> deleteNote(String id){
    return _db
    .collection('note')
    .document(id)
    .delete();
  }
}
