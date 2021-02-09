import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/models/user.dart';

class Review {
  final int id;
  final String review;
  final double star;
  final String createdAt;

  Review({this.id, this.review, this.star, this.createdAt});

  Review.fromMap(Map<String, dynamic> mapData)
      : id = mapData['id'] ?? null,
        review = mapData['review'] ?? '',
        star = mapData['star'] != null ? double.parse(mapData['star']) :  0,
        createdAt = mapData['created_at'] ?? '';

  @override
  String toString() => 'Reviews { id: $id, review: $review }';
}

class Location {
  final int id;
  final double lat;
  final double lng;
  final String address;

  Location({this.id, this.lat, this.lng, this.address});

  Location.fromMap(Map<String, dynamic> mapData)
      : id = mapData['id'] ?? null,
        lat = mapData['lat'] != null ? double.parse(mapData['lat']) : 0,
        lng = mapData['lng'] != null ? double.parse(mapData['lng']) : 0,
        address = mapData['address'] ?? '';

  @override
  String toString() => 'Location { id: $id, address: $address }';

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'lat': lat, 'lng': lng, 'address': address};
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}

class Ride {
  final int id;
  final Location pickupLocation;
  final Location deliveryLocation;
  final User user;
  final Driver rider;
  final String createdAt;
  final double price;
  final String distance;
  final String receiverName;
  final String receiverPhone;
  final String status;
  final String rideId;
  Review review;
  final String duration;
  final bool isPickedUp;

  Ride(
      {this.id,
      this.pickupLocation,
      this.deliveryLocation,
      this.user,
      this.rider,
      this.createdAt,
      this.price,
        this.review,
      this.distance,
      this.receiverName,
      this.receiverPhone,
      this.status,
      this.rideId,
        this.duration,
      this.isPickedUp});

  Ride.fromMap(Map<String, dynamic> mapData)
      : id = mapData['id'] ?? null,
      review = mapData['review'] != null ? Review.fromMap(mapData['review']): null,
        pickupLocation = mapData['pickup_location'] != null
            ? Location.fromMap(mapData['pickup_location'])
            : null,
        deliveryLocation = mapData['delivery_location'] != null
            ? Location.fromMap(mapData['delivery_location'])
            : null,
        user = mapData['user'] != null ? User.fromMap(User().formatToMap(mapData['user'])) : null,
        rider =
            mapData['rider'] != null ? Driver.fromMap(Driver().formatToMap(mapData['rider'])) : null,
        createdAt = mapData['created_at'] ?? '',
        price = mapData['price'] != null ? double.parse(mapData['price']) : 0.0,
        distance = mapData['distance'] ?? '',
        receiverName = mapData['receiver_name'] ?? '',
        receiverPhone = mapData['receiver_phone'] ?? '',
        status = mapData['status'] ?? '',
        rideId = mapData['ride_id'] ?? '',
        duration = mapData['duration'] ?? '',
        isPickedUp = mapData['picked_up'] ?? false;

  @override
  String toString() => 'Ride { id: $id, rideId: $rideId, status: $status }';

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'pickup_location': pickupLocation.toMap(),
      'delivery_location': deliveryLocation.toMap(),
      'user': user.toMap(),
      'rider': rider.toMap(),
      'created_at': createdAt,
      'price': price,
      'distance': distance,
      'receiver_name': receiverName,
      'receiver_phone': receiverPhone,
      'status': status,
      'ride_id': rideId,
      'duration': duration,
      'picked_up': isPickedUp
    };
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
