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

  //* this property is to reduce load when sending multiple message instantaneous
  int queue = 0;

  int _id;
  int get id => _id;

  Future getId() async {
    _id = await BaseProvider.getCurrentMemberId();
    getMessages();
  }

  Future getMessages() async {
    print('get Messages');
    messages = await chatApi.getMessageById(id);
    notifyListeners();
  }

  Future addMessage({@required String content}) async {
    queue++;
    print('addMessage');
    // Add new message to screen
    Message message = Message(content: content, isAdmin: 0);
    messages.insert(0, message);
    notifyListeners();

    // send it to server and verify it
    // if sucess will reduce the queue
    await chatApi.addMessage(id, content).then((value) {
      queue--;
    });

    // rebuild message list when all message sent
    if (queue == 0) {
      getMessages();
    }

    return true;
  }
}
