import 'package:flutter/cupertino.dart';
import 'package:kamera_teman_client/core/models/message.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/chat_api.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider() {
    print('chat provider created');
  }
  ChatApi chatApi = ChatApi();
  List<Message> messages;

  Future getMessages() async {
    messages = await chatApi.getMessageById(await BaseProvider.getCurrentMemberId());
    notifyListeners();
  }

  Future addMessage({@required String content}) async {
    var res = await chatApi.addMessage(await BaseProvider.getCurrentMemberId(), content);
    getMessages();
    return res;
  }
}
