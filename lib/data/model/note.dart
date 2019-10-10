class Note {
  final String title;
  final String description;
  final String id;

  //Constructor
  Note({this.title, this.description, this.id});

  // fromMap + dynamic -> va convertir Note en objet
  Note.fromMap(Map<String, dynamic> data, String id):
    title = data["title"],
    description = data["description"],
    id = id;
}