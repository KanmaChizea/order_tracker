import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/dependency_injection/injection_container.dart';
import 'package:order_tracker/model/order.dart';
import 'package:order_tracker/services/ably.dart';
import 'package:order_tracker/utils/dummy_data.dart';

class OrderCubit extends Cubit<Order?> {
  OrderCubit() : super(sampleOrder);

  final _ablyService = sl.get<AblyService>();

  Future<void> initializeTracking() async {
    await _ablyService.connect();
    final statusStream = _ablyService.subscribe(channelName: 'orderStatus');

    statusStream.listen((status) {
      if (status != null && state != null) {
        emit(state!.updateStatus(status, DateTime.now()));
      }
    });
  }

  Future<void> stopTracking() async {
    await _ablyService.close();
  }

  void concludeOrder() => emit(null);

  void resetOrder() => emit(sampleOrder);
}
