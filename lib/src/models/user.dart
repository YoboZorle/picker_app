import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String firstname;
  final String lastname;
  final int onlineStatus;
  final String phone;
  final String profileImageUrl;
  final String callingCode;
  final String email;

  User(
      {this.id,
      this.firstname,
      this.lastname,
      this.phone,
        this.email,
      this.callingCode,
      this.profileImageUrl,
      this.onlineStatus});

  @override
  List<Object> get props => [id, firstname, lastname, onlineStatus, email];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'callingCode': callingCode,
      'onlineStatus': onlineStatus
    };
    if (id != null) {
      map['_userId'] = id;
    }

    return map;
  }

  User.fromMap(Map<String, dynamic> mapData)
      : id = mapData['userId'] ?? null,
        firstname = mapData['firstname'] ?? '',
        lastname = mapData['lastname'] ?? '',
        phone = mapData['phone'] ?? '',
        email = mapData['email'] ?? '',
        profileImageUrl = mapData['profileImageUrl'] ?? '',
        callingCode = mapData['callingCode'] ?? '',
        onlineStatus = mapData['onlineStatus'];

  @override
  String toString() => 'User { id: $id, firstname: $firstname }';
}
