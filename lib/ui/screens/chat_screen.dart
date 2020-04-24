import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamera_teman_client/core/models/message.dart';
import 'package:kamera_teman_client/core/providers/chat_provider.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController cMessage = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //Todo add onresume get message

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    //* This function is to make sure that getMessage will be called everytime the screen changes
    Provider.of<ChatProvider>(context, listen: false).getId();

    return Consumer<ChatProvider>(
      builder: (context, chatProv, _) {
        print('ChatScreen build');
        if (chatProv.messages == null) {
          // chatProv.getMessages();
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Pesan Admin'),
            backgroundColor: Styles.darkPurple,
          ),
          body: Column(
            children: <Widget>[
              _buildChatList(chatProv, mq),
              _buildChatSend(mq, chatProv, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChatSend(Size mq, ChatProvider chatProv, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Form(
        key: _formKey,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: mq.width - 60,
              child: TextField(
                maxLines: null,
                controller: cMessage,
              ),
            ),
            InkWell(
              onTap: () async {
                String text = cMessage.text;
                if (text.trim().isNotEmpty) {
                  cMessage.text = "";
                  var res = await chatProv.addMessage(content: text.toString());

                  if (res != true) {
                    showToast("Please cek your internet connection");
                  }
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
      ),
    );
  }

  Widget _buildChatList(ChatProvider chatProv, mq) {
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
            return _buildChat(message, mq);
          },
        ),
      ),
    );
  }

  Row _buildChat(Message message, mq) {
    return Row(
      mainAxisAlignment: message.isAdmin == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: mq.width * 0.7),
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
            softWrap: true,
            style: GoogleFonts.openSans(
              color: message.isAdmin == 0 ? Colors.black : Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 50),
        message.isAdmin == 0
            ? Icon(
                Icons.check,
                size: 20,
                color: message.id == null ? Colors.grey[400] : Styles.darkPurple,
              )
            : Container()
      ],
    );
  }
}
