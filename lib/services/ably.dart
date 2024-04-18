import 'dart:developer';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:order_tracker/model/order.dart';

class AblyService {
  static final _clientOptions = ably.ClientOptions(key: dotenv.env['ABLY_KEY']);
  final _realtime = ably.Realtime(options: _clientOptions);

  Future<void> connect() async {
    _realtime.connection
        .on(ably.ConnectionEvent.connected)
        .listen((ably.ConnectionStateChange stateChange) async {
      log('New state is: ${stateChange.current}');
      switch (stateChange.current) {
        case ably.ConnectionState.connected:
          log('Connected to Ably!');
          break;
        case ably.ConnectionState.failed:
          break;
        default:
        //
      }
    });
  }

  Stream<OrderStatus?> subscribe({required String channelName}) {
    final channel = _realtime.channels.get(channelName);
    return channel.subscribe().map((message) {
      switch (message.data.toString().toLowerCase()) {
        case 'order accepted':
          return OrderStatus.accepted;
        case 'order pick up in progress':
          return OrderStatus.pickup;
        case 'order on the way to customer':
          return OrderStatus.enroute;
        case 'order arrived':
          return OrderStatus.arrived;
        case 'order delivered':
          return OrderStatus.delivered;
        default:
          return null;
      }
    });
  }

  Future<void> close() async {
    _realtime.connection.close();
    _realtime.connection
        .on(ably.ConnectionEvent.closed)
        .listen((ably.ConnectionStateChange stateChange) async {
      log('New state is: ${stateChange.current}');
      switch (stateChange.current) {
        case ably.ConnectionState.closed:
          log('Closed the connection to Ably.');
          break;
        case ably.ConnectionState.failed:
          break;
        default:
      }
    });
  }
}
