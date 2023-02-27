// ignore_for_file: public_member_api_docs, sort_constructors_first
class Dept {
  final  String? id;
  final  double done;
  final  double dept;
  final DateTime? date;
  Dept({
    this.id,
    required this.done,
    required this.dept,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'done': done,
      'dept': dept,
      'date': date!.millisecondsSinceEpoch,
    };
  }

  factory Dept.fromJson(Map<String, dynamic> map) {
    return Dept(
      id: map['id'] as String,
      done: map['done'] as double,
      dept: map['dept'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
}
}