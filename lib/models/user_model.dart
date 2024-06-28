class UserModel {
  final String username;
  final String password;
  final String emailOrPhone;
  final String birth;
  final String uid;
  final String name;

  const UserModel({
    required this.username,
    required this.password,
    required this.emailOrPhone,
    required this.birth,
    required this.uid,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email or phone': emailOrPhone,
      'birth': birth,
      'uid': uid,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      password: map['password'] as String,
      emailOrPhone: map['emailOrPhone'] as String,
      birth: map['birth'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
    );
  }
}