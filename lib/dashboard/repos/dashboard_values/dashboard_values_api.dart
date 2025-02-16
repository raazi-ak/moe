import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:moe/dashboard/repos/dashboard_values/system_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SystemWebSocketRepository {
  final System system;
  late WebSocketChannel channel;
  final StreamController<Map<String, dynamic>> _dataController = StreamController.broadcast();
  String _messageBuffer = '';

  SystemWebSocketRepository(this.system);

  Stream<Map<String, dynamic>> get dataStream => _dataController.stream;

  Future<void> connectWebSocket() async {
    final uri = Uri.parse('wss://ojil6u53db.execute-api.eu-central-1.amazonaws.com/production/?tableName=moe_${system.id}');
    channel = WebSocketChannel.connect(uri);

    final payload = {
      "action": "sendMessage",
      "body": {"tableName": "moe_${system.id}"}
    };
    final initialPayload = jsonEncode(payload);

    try {
      await channel.ready;
      print("Connection established for system ${system.id}");
      channel.sink.add(initialPayload);
      _listenToStream();
    } catch (e) {
      print("WebSocket Error: $e");
      rethrow;
    }
  }

  void _listenToStream() {
    channel.stream.listen(
          (message) {
        _messageBuffer += message;
        _processBuffer();
      },
      onError: (error) {
        print("WebSocket Error: $error");
      },
      onDone: () {
        print("WebSocket closed. Reconnecting...");
        _messageBuffer = '';
        //connectWebSocket();
      },
      cancelOnError: true,
    );
  }

  void _processBuffer() {
    try {
      var decodedMessage = jsonDecode(_messageBuffer);
      _messageBuffer = '';
      _dataController.add(decodedMessage);
    } catch (e) {
      print("Incomplete WebSocket message. Buffering...");
    }
  }

  void closeConnection() {
    channel.sink.close();
    _dataController.close();
  }
}
