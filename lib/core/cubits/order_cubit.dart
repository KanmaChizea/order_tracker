import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/dependency_injection/injection_container.dart';
import 'package:order_tracker/model/item.dart';
import 'package:order_tracker/model/order.dart';
import 'package:order_tracker/model/order_timestamps.dart';
import 'package:order_tracker/services/ably.dart';

class OrderCubit extends Cubit<Order?> {
  OrderCubit() : super(null);

  final _ablyService = sl.get<AblyService>();

  Future<void> initializeTracking() async {
    await _ablyService.connect();
    resetOrder();
    final statusStream = _ablyService.subscribe(channelName: 'orderStatus');
    statusStream.listen((status) {
      if (status != null && state != null) {
        emit(
          state!.updateStatus(status),
        );
      }
    });
  }

  Future<void> stopTracking() async {
    resetOrder();
  }

  void concludeOrder() => emit(null);

  void resetOrder() {
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
    emit(sampleOrder);
  }
}
