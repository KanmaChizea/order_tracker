class OrderTimestamps {
  OrderTimestamps({
    required this.placedTime,
    this.acceptedTime,
    this.pickupTime,
    this.enrouteTime,
    this.arrivedTime,
    this.deliveredTime,
  });

  final DateTime placedTime;
  final DateTime? acceptedTime;
  final DateTime? pickupTime;
  final DateTime? enrouteTime;
  final DateTime? arrivedTime;
  final DateTime? deliveredTime;

  OrderTimestamps copyWith({
    DateTime? placedTime,
    DateTime? acceptedTime,
    DateTime? pickupTime,
    DateTime? enrouteTime,
    DateTime? arrivedTime,
    DateTime? deliveredTime,
  }) {
    return OrderTimestamps(
      placedTime: placedTime ?? this.placedTime,
      acceptedTime: acceptedTime ?? this.acceptedTime,
      pickupTime: pickupTime ?? this.pickupTime,
      enrouteTime: enrouteTime ?? this.enrouteTime,
      arrivedTime: arrivedTime ?? this.arrivedTime,
      deliveredTime: deliveredTime ?? this.deliveredTime,
    );
  }
}
