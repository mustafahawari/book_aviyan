import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? fullName;
  int? phoneNumber;
  String? email;
  String? imageUrl;
  UserModel({this.userId, this.fullName, this.phoneNumber, this.email});
  Map<String, dynamic> toMap() {
    return {
      "uesrId": userId,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "joinedAt": Timestamp.now(),
      "imageUrl": imageUrl
    };
  }
}
