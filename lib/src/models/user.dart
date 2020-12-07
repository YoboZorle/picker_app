import 'package:equatable/equatable.dart';

_isUserDriver(value){
  if(value == null)return false;
  if(value is bool) return value;
  if(value == 0) return false;
  return true;
}

class User extends Equatable {
  final int id;
  final String fullname;
  final String phone;
  final String profileImageUrl;
  final String callingCode;
  final String email;
  final bool isDriver;

  bool get isCompleteDetails {
    return email != null &&
        email.isNotEmpty &&
        profileImageUrl != null &&
        profileImageUrl.isNotEmpty;
  }

  User(
      {this.id,
      this.fullname,
      this.phone,
      this.email,
      this.callingCode,
      this.profileImageUrl, this.isDriver});

  @override
  List<Object> get props => [id, fullname, email];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'callingCode': callingCode,
      'is_driver': isDriver == true ? 1: 0
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
        isDriver = _isUserDriver(mapData['is_driver']),
        callingCode = mapData['callingCode'] ?? '';

  @override
  String toString() => 'User { id: $id, fullname: $fullname, phone: $phone }';
}
