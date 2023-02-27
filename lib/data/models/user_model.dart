// ignore_for_file: public_member_api_docs, sort_constructors_first
class Users {
  final String id;
  final String userName;
  final String email;
  Users({
    required this.id,
    required this.userName,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'email': email,
    };
  }

  factory Users.fromJson(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
    );
  }
}
