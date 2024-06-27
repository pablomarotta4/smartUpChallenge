class UserModel {
  final String username;
  final String password;
  final String email;
  final String phone;
  final String birth;

  const UserModel({
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.birth,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      'birth': birth,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      birth: map['birth'] as String
    );
  }
}