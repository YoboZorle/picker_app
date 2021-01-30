class Wallet {
  final int id;
  final double balance;
  final double debts;

  Wallet({this.id, this.balance, this.debts});

  Wallet.fromMap(Map<String, dynamic> mapData)
      : id = mapData['id'],
        balance =
            mapData['balance'] != null ? double.parse(mapData['balance']) : 0,
        debts = mapData['debts'] != null ? double.parse(mapData['debts']) : 0;

  Map<String, dynamic> toMap() {
    var map = {'id': id, 'balance': balance, 'debts': debts};
    return map;
  }
}
