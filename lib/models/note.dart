class Note {
  int? id;
  late String title;
  late String text;

  Note(this.title, this.text);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text
    };
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    text = map['text'];
  }
}