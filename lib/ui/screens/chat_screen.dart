import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman_client/core/models/message.dart';
import 'package:kamera_teman_client/core/providers/chat_provider.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:kamera_teman_client/ui/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController cMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Consumer<ChatProvider>(
      builder: (context, chatProv, _) {
        if (chatProv.messages == null) {
          chatProv.getMessages();
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Pesan Admin'),
            backgroundColor: Styles.darkPurple,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildChatList(chatProv),
              _buildChatSend(mq, chatProv),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChatSend(Size mq, ChatProvider chatProv) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            width: mq.width - 60,
            child: TextFieldWidget(
              cText: cMessage,
              hintText: 'Ketik pesan disini',
            ),
          ),
          InkWell(
            onTap: () async {
              var res = await chatProv.addMessage(content: cMessage.text.toString());
              if (res == true) {
                cMessage.text = "";
                print("cMessage deleted");
              }
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Styles.darkPurple,
              ),
              child: Icon(
                Icons.send,
                size: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChatList(ChatProvider chatProv) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(color: Styles.coolWhite),
        child: ListView.builder(
          itemCount: chatProv.messages.length,
          reverse: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            Message message = chatProv.messages[index];
            return _buildChat(message);
          },
        ),
      ),
    );
  }

  Row _buildChat(Message message) {
    return Row(
      mainAxisAlignment: message.isAdmin == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: message.isAdmin == 0 ? Colors.white : Styles.darkPurple,
              borderRadius: BorderRadius.only(
                  bottomLeft: message.isAdmin == 0 ? Radius.circular(10) : Radius.circular(0),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          child: Text(
            message.content,
            style: GoogleFonts.openSans(
              color: message.isAdmin == 0 ? Colors.black : Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
