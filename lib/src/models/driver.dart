import 'package:equatable/equatable.dart';
import 'package:pickrr_app/src/models/user.dart';

bool _driverStatus(value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value == 0) return false;
  return true;
}

class Driver extends Equatable {
  final int id;
  final String plateNumber;
  final String ticketNumber;
  final String companyName;
  final String status;
  final String createdAt;
  final bool blocked;
  final User details;

  Driver(
      {this.id,
      this.plateNumber,
      this.ticketNumber,
      this.companyName,
      this.status,
      this.blocked,
      this.createdAt,
      this.details});

  @override
  List<Object> get props => [id, ticketNumber, companyName, createdAt];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'plateNumber': plateNumber,
      'ticketNumber': ticketNumber,
      'companyName': companyName,
      'status': status,
      'createdAt': createdAt,
      'blocked': blocked == true ? 1 : 0
    };
    if (id != null) {
      map['_userId'] = id;
    }

    return map;
  }

  Map<String, dynamic> formatToMap(rawData) {
    var map = <String, dynamic>{
      'id': rawData['id'],
      'user': rawData['user'],
      'plateNumber': rawData['plate_number'],
      'ticketNumber': rawData['ticket_number'],
      'companyName': rawData['company_name'],
      'status': rawData['status'],
      'createdAt': rawData['created_at'],
      'blocked': rawData['blocked']
    };

    return map;
  }

  Driver.fromMap(Map<String, dynamic> mapData)
      : id = mapData['id'] ?? mapData['_userId'] ?? null,
        details =
            mapData['user'] != null ? User.fromMap(User().formatToMap(mapData['user'])) : null,
        plateNumber = mapData['plateNumber'] ?? '',
        ticketNumber = mapData['ticketNumber'] ?? '',
        companyName = mapData['companyName'] ?? '',
        status = mapData['status'],
        createdAt = mapData['createdAt'],
        blocked = _driverStatus(mapData['blocked']);

  @override
  String toString() =>
      'Driver { id: $id, ticketNumber: $ticketNumber, companyName: $companyName }';
}
