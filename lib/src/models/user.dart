import 'package:equatable/equatable.dart';

_intToBool(value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value == 0) return false;
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
  final bool isBusiness;
  final bool isNewBusiness;

  bool get isCompleteDetails {
    return email != null && email.isNotEmpty;
  }

  bool get noProfileImage {
    return profileImageUrl == null ||
        profileImageUrl.isEmpty ||
        profileImageUrl == 'None';
  }

  User(
      {this.id,
      this.fullname,
      this.phone,
      this.email,
      this.callingCode,
      this.profileImageUrl,
      this.isDriver,
      this.isBusiness,
      this.isNewBusiness});

  @override
  List<Object> get props => [id, fullname, email];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'callingCode': callingCode,
      'is_driver': isDriver == true ? 1 : 0,
      'is_business': isDriver == true ? 1 : 0,
      'is_new_business': isNewBusiness == true ? 1 : 0
    };
    if (id != null) {
      map['_userId'] = id;
    }

    return map;
  }

  Map<String, dynamic> formatToMap(rawData) {
    var map = <String, dynamic>{
      'userId': rawData['id'],
      'fullname': rawData['fullname'],
      'email': rawData['email'],
      'phone': rawData['phone'],
      'profileImageUrl': rawData['photo'],
      'callingCode': rawData['calling_code'].toString(),
      'is_driver': rawData['is_driver'],
      'is_business': rawData['is_business'],
      'is_new_business': rawData['is_new_business']
    };

    return map;
  }

  User.fromMap(Map<String, dynamic> mapData)
      : id = mapData['userId'] ?? mapData['_userId'] ?? null,
        fullname = mapData['fullname'] ?? '',
        phone = mapData['phone'] ?? '',
        email = mapData['email'] ?? '',
        profileImageUrl = mapData['profileImageUrl'] ?? '',
        isDriver = _intToBool(mapData['is_driver']),
        isBusiness = _intToBool(mapData['is_business']),
        isNewBusiness = _intToBool(mapData['is_new_business']),
        callingCode = mapData['callingCode'] ?? '';

  @override
  String toString() => 'User { id: $id, fullname: $fullname, phone: $phone }';
}
