import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rfilesaver/rfilesaver_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelRfilesaver platform = MethodChannelRfilesaver();
  const MethodChannel channel = MethodChannel('rfilesaver');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}
