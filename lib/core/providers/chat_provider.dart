import 'package:flutter/cupertino.dart';
import 'package:kamera_teman_client/core/models/message.dart';
import 'package:kamera_teman_client/core/providers/base_provider.dart';
import 'package:kamera_teman_client/core/services/chat_api.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider() {
    print('chat provider created');
    getId();
  }
  ChatApi chatApi = ChatApi();
  List<Message> messages;

  int _id;
  int get id => _id;

  Future getId() async {
    _id = await BaseProvider.getCurrentMemberId();
    getMessages();
  }

  Future getMessages() async {
    messages = await chatApi.getMessageById(id);
    print('get Messages');
    notifyListeners();
  }

  Future addMessage({@required String content}) async {
    print('addMessage');
    // Add new message to screen
    Message message = Message(content: content, isAdmin: 0);
    messages.insert(0, message);
    notifyListeners();

    // send it to server and verify it
    var res = await chatApi.addMessage(id, content);
    getMessages();
    return res;
  }
}
