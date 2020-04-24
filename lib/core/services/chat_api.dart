import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kamera_teman_client/core/models/message.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';

class ChatApi {
  //* Function to get messages
  // params id
  // res list<Message>
  Future<List<Message>> getMessageById(int id) async {
    var link = linkApi + "getConversationByUserId/$id";
    List<Message> messages = [];
    try {
      var res = await http.get(link);
      var jsonObject = await json.decode(res.body);
      if (jsonObject == []) {
        return messages;
      }
      List<dynamic> dataJson = jsonObject;

      for (var data in dataJson) messages.add(Message.fromJson(data));
    } on Exception catch (e) {
      print(e);
    }
    return messages;
  }

  Future addMessage(int id, String content) async {
    var link = linkApi + "addMessageToConversation/$id";

    Map<String, String> body = {
      "message": content,
      "is_admin": "0",
    };

    await http.post(link, body: body);
    return true;
  }
}
