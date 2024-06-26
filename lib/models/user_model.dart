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
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      emailOrPhone: map[''] ?? '',
      birth: map['birth'] ?? '',
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
