// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// import 'rfilesaver_method_channel.dart';

// abstract class RfilesaverPlatform extends PlatformInterface {
//   /// Constructs a RfilesaverPlatform.
//   RfilesaverPlatform() : super(token: _token);

//   static final Object _token = Object();

//   static RfilesaverPlatform _instance = MethodChannelRfilesaver();

//   /// The default instance of [RfilesaverPlatform] to use.
//   ///
//   /// Defaults to [MethodChannelRfilesaver].
//   static RfilesaverPlatform get instance => _instance;

//   /// Platform-specific implementations should set this with their own
//   /// platform-specific class that extends [RfilesaverPlatform] when
//   /// they register themselves.
//   static set instance(RfilesaverPlatform instance) {
//     PlatformInterface.verifyToken(instance, _token);
//     _instance = instance;
//   }

//   Future<String?> getPlatformVersion() {
//     throw UnimplementedError('platformVersion() has not been implemented.');
//   }
// }
