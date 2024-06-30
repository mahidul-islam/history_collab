import 'dart:convert';

class UserData {
  String? userName;
  String? email;
  String? role;

  UserData({
    this.userName,
    this.email,
    this.role,
  });

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userName: json["userName"],
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "role": role,
      };
}
