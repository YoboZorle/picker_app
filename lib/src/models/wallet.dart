class Wallet {
  final int id;
  final double balance;
  final double debts;

  Wallet({this.id, this.balance, this.debts});

  Wallet.fromMap(Map<String, dynamic> mapData)
      : id = mapData['id'],
        balance =
            mapData['balance'] != null ? double.parse(mapData['balance']) : 0,
        debts = mapData['total_debt'] != null ? double.parse(mapData['total_debt']) : 0;

  Map<String, dynamic> toMap() {
    var map = {'id': id, 'balance': balance, 'total_debt': debts};
    return map;
  }
}

class Bank {
  final String bankCode;
  final String bankName;

  Bank({this.bankCode, this.bankName});

  Bank.fromMap(Map<String, dynamic> mapData)
      : bankName = mapData['name'] ?? '',
        bankCode = mapData['code'] ?? '';

  Map<String, dynamic> toMap() {
    return {'bankName': bankName, 'bankCode': bankCode};
  }
}
