import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String fullname;
  final String phone;
  final String profileImageUrl;
  final String callingCode;
  final String email;

  bool get isCompleteDetails {
    return email != null ||
        email.isNotEmpty ||
        profileImageUrl != null ||
        profileImageUrl.isNotEmpty;
  }

  User(
      {this.id,
      this.fullname,
      this.phone,
      this.email,
      this.callingCode,
      this.profileImageUrl});

  @override
  List<Object> get props => [id, fullname, email];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'callingCode': callingCode
    };
    if (id != null) {
      map['_userId'] = id;
    }

    return map;
  }

  User.fromMap(Map<String, dynamic> mapData)
      : id = mapData['userId'] ?? mapData['_userId'] ?? null,
        fullname = mapData['fullname'] ?? '',
        phone = mapData['phone'] ?? '',
        email = mapData['email'] ?? '',
        profileImageUrl = mapData['profileImageUrl'] ?? '',
        callingCode = mapData['callingCode'] ?? '';

  @override
  String toString() => 'User { id: $id, fullname: $fullname, phone: $phone }';
}
