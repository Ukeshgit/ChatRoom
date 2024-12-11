import 'package:chatapp/app/chat/model/chat_model.dart';
import 'package:chatapp/const/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.messages});
  final ChatModel messages;

  @override
  Widget build(BuildContext context) {
    return Apis.user.uid == messages.fromId ? _greenMessage() : _blueMessage();
  }

  //sender or another user message
  Widget _blueMessage() {
    return Container(
      child: Text(
        messages.msg!,
        style: TextStyle(color: Colors.red, fontSize: 11),
      ),
    );
  }

  //our or user message
  Widget _greenMessage() {
    return Container();
  }
}
