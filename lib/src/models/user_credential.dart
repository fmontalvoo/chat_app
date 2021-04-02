import 'dart:convert';

import 'package:chat_app/src/models/user_model.dart';

UserCredential userCredentialFromJson(String str) =>
    UserCredential.fromJson(json.decode(str));

String userCredentialToJson(UserCredential data) => json.encode(data.toJson());

class UserCredential {
  bool ok;
  UserModel user;
  String token;

  UserCredential({
    this.ok,
    this.user,
    this.token,
  });

  factory UserCredential.fromJson(Map<String, dynamic> json) => UserCredential(
        ok: json["ok"],
        user: UserModel.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user.toJson(),
        "token": token,
      };
}
