

class Invoice {
  final  String? id;
  final  String name; //!  Invoice Name and user name is the same 
  final  double total;
  final  double? deptTotal;
  final  String imageUrl;
  final  String notes;
  final  bool isDelivered;
  final  DateTime? date;

  Invoice({
    this.id,
    required this.name,
    required this.total,
    this.deptTotal,
    required this.imageUrl,
    required this.notes,
    required this.isDelivered,
    this.date,
  });


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'total': total,
      'deptTotal': deptTotal,
      'imageUrl':imageUrl,
      'notes':notes,
      'isDelivered':isDelivered,
      'date': date!.millisecondsSinceEpoch,
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] as String,
      name: map['name'] as String,
      total: map['total'] as double,
      deptTotal: map['deptTotal'] as double,
      imageUrl: map['imageUrl'],
      notes: map['notes'],
      isDelivered: map['isDelivered'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }


}
