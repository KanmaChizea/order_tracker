import 'package:order_tracker/model/item.dart';
import 'package:order_tracker/model/order.dart';
import 'package:order_tracker/model/order_timestamps.dart';

final items = [
  Item(
    id: 'Item1',
    quantity: 2,
    price: 1000,
    name: 'Breakfast Combo',
    description: 'Bread and 3pcs of Akara',
    imagePath: 'lib/assets/images/bread.jpeg',
  ),
  Item(
    id: 'Item2',
    quantity: 1,
    price: 200,
    name: 'Water',
    description: 'Aqua bottled water',
    imagePath: 'lib/assets/images/water.jpeg',
  ),
];
final sampleOrder = Order(
  id: '123',
  items: items,
  date: DateTime.now(),
  status: OrderStatus.placed,
  timestamps: OrderTimestamps(
    placedTime: DateTime.now(),
  ),
);
