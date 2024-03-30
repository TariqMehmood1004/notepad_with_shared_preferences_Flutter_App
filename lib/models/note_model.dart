class NoteModel {
  String title;
  DateTime date;
  bool isCompleted;

  NoteModel({
    required this.title,
    required this.date,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toString(),
      'isCompleted': isCompleted,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'],
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'],
    );
  }

  NoteModel copyWith({
    String? title,
    DateTime? date,
    bool? isCompleted,
  }) {
    return NoteModel(
      title: title ?? this.title,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
