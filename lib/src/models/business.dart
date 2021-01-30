import 'package:pickrr_app/src/models/wallet.dart';

class Business {
  final int id;
  final String name;
  final String logo;
  final String location;
  final String email;
  final String phone;
  final bool blocked;
  final Wallet wallet;

  Business(
      {this.id,
      this.name,
      this.logo,
      this.location,
      this.email,
      this.phone,
      this.blocked,
      this.wallet});

  Business.fromMap(Map<String, dynamic> mapData)
      : id = mapData['id'] ?? null,
        name = mapData['name'] ?? null,
        logo = mapData['logo'] ?? null,
        location = mapData['location'] ?? null,
        email = mapData['email'] ?? null,
        phone = mapData['phone'] ?? null,
        blocked = mapData['blocked'] ?? null,
        wallet = mapData['wallet'] ?? null;

  Map<String, dynamic> toMap() {
    var map = {
      'id': id,
      'name': name,
      'logo': logo,
      'location': location,
      'email': email,
      'phone': phone,
      'blocked': blocked
    };

    return map;
  }
}
