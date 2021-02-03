import 'package:pickrr_app/src/models/wallet.dart';

_intToBool(value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value == 0) return false;
  return true;
}

class Business {
  final int id;
  final String name;
  final String logo;
  final String location;
  final String email;
  final String phone;
  final bool blocked;
  final Wallet wallet;
  final double balance;
  final String balanceHumanized;

  Business(
      {this.id,
      this.name,
      this.logo,
      this.location,
      this.email,
      this.phone,
      this.blocked,
      this.wallet,
        this.balance,
      this.balanceHumanized});

  Business.fromMap(Map<String, dynamic> mapData)
      : id = mapData['id'] ?? null,
        name = mapData['name'] ?? null,
        logo = mapData['logo'] ?? null,
        location = mapData['location'] ?? null,
        email = mapData['email'] ?? null,
        phone = mapData['phone'] ?? null,
        blocked = _intToBool(mapData['blocked']),
        balanceHumanized =
            mapData['wallet'] == null
                ? mapData['balance_humanized']
                : mapData['wallet']['balance_humanized'],
        balance =
            mapData['wallet'] == null
                ? double.parse(mapData['balance'])
                : double.parse(mapData['wallet']['balance']),
        wallet = mapData['wallet'] == null
            ? null
            : Wallet.fromMap(mapData['wallet']);

  Map<String, dynamic> toMap() {
    var map = {
      'id': id,
      'name': name,
      'logo': logo,
      'location': location,
      'email': email,
      'phone': phone,
      'blocked': blocked == true ? 1 : 0,
      'balance_humanized': balanceHumanized,
      'balance': balance.toString(),
    };

    return map;
  }
}
