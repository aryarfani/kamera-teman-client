import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/providers/chat_provider.dart';
import 'package:kamera_teman_client/core/services/member_api.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    // final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    // final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class PushNotificationService {
  final ChatProvider chatProvider;
  PushNotificationService(this.chatProvider);

  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future init() async {
    await getAndSaveToken();
    _fcm.configure(
      // when app is open (foreground)
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage ${message['notification']['title']}');

        if (message['notification']['title'] == "Anda mempunyai pesan baru") {
          // trigger function in provider
          chatProvider.getMessages();
        }
      },
      // when app is in background
      onResume: (Map<String, dynamic> message) async {
        print('onResume $message');

        if (message['notification']['title'] == "Anda mempunyai pesan baru") {
          // trigger function in provider
          chatProvider.getMessages();
        }
      },
      // when app has been terminated
      onBackgroundMessage: myBackgroundMessageHandler,
    );
  }

  Future getAndSaveToken() async {
    var token = await _fcm.getToken();
    MemberApi().saveToken(await BaseProvider.getCurrentMemberId(), token);
    print(token);
  }
}
