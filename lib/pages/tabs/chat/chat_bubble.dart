import 'package:ajanchat/constants/relation_type_colors.dart';
import 'package:ajanchat/models/ERelationType.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {

  String message;
  bool isSender;
  ERelationType relationType;

  ChatBubble({
    required this.message,
    required this.isSender,
    required this.relationType
  });

  @override
  Widget build(BuildContext context) {

    return Bubble(
      color: isSender
          ? const Color.fromRGBO(255, 255, 255, 0.1)
          : relationType == ERelationType.friend ? FriendColor : relationType == ERelationType.serious ? SeriousColor : FlirtColor,
      child: Text(message, style: TextStyle(color: isSender ? Colors.black : Colors.white)),
      nip: isSender ? BubbleNip.rightTop : BubbleNip.leftTop,
      margin: const BubbleEdges.all(5.0),
      alignment: isSender ? Alignment.bottomRight : Alignment.bottomLeft,
    );
  }
}
