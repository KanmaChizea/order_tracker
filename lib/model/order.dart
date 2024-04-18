import 'package:flutter/foundation.dart';

import 'package:order_tracker/model/item.dart';
import 'package:order_tracker/model/order_timestamps.dart';

enum OrderStatus { placed, accepted, pickup, enroute, arrived, delivered }

class Order {
  Order({
    required this.id,
    required this.items,
    required this.date,
    required this.status,
    required this.timestamps,
  });

  final String id;
  final List<Item> items;
  final DateTime date;
  final OrderStatus status;
  final OrderTimestamps timestamps;

  Order updateStatus(OrderStatus newStatus, DateTime time) {
    final newTimestamps = switch (newStatus) {
      OrderStatus.placed => timestamps.copyWith(placedTime: time),
      OrderStatus.arrived => timestamps.copyWith(arrivedTime: time),
      OrderStatus.accepted => timestamps.copyWith(acceptedTime: time),
      OrderStatus.pickup => timestamps.copyWith(pickupTime: time),
      OrderStatus.delivered => timestamps.copyWith(deliveredTime: time),
      OrderStatus.enroute => timestamps.copyWith(enrouteTime: time),
    };
    return Order(
      id: id,
      items: items,
      date: date,
      status: newStatus,
      timestamps: newTimestamps,
    );
  }

  String getStatusString([OrderStatus? status]) {
    switch (status ?? this.status) {
      case OrderStatus.placed:
        return 'Order placed';
      case OrderStatus.accepted:
        return 'Order accepted';
      case OrderStatus.pickup:
        return 'Order pick up in progress';
      case OrderStatus.enroute:
        return 'Order on the way';
      case OrderStatus.arrived:
        return 'Order arrived';
      case OrderStatus.delivered:
        return 'Order delivered';
      default:
        return '-';
    }
  }

  String getStatusDescription([OrderStatus? status]) {
    switch (status ?? this.status) {
      case OrderStatus.placed:
        return 'Waiting for vendor to confirm your order';
      case OrderStatus.accepted:
        return 'The vendor is preparing your order and a rider will pick it up soon';
      case OrderStatus.pickup:
        return 'A rider is on the way to the vendor to pickup your order';
      case OrderStatus.enroute:
        return 'Your order has been picked up and is on its way to you!';
      case OrderStatus.arrived:
        return 'Your order is here! Please don\'t keep the rider waiting';
      case OrderStatus.delivered:
        return 'Enjoy!';
      default:
        return '-';
    }
  }

  DateTime? getStatusDate([OrderStatus? status]) {
    return switch (status ?? this.status) {
      OrderStatus.placed => timestamps.placedTime,
      OrderStatus.accepted => timestamps.acceptedTime,
      OrderStatus.pickup => timestamps.pickupTime,
      OrderStatus.enroute => timestamps.enrouteTime,
      OrderStatus.arrived => timestamps.arrivedTime,
      OrderStatus.delivered => timestamps.deliveredTime,
    };
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.items, items) &&
        other.date == date &&
        other.status == status &&
        other.timestamps == timestamps;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        items.hashCode ^
        date.hashCode ^
        status.hashCode ^
        timestamps.hashCode;
  }
}
