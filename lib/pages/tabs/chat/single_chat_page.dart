import 'package:ajanchat/pages/tabs/chat/chat_app_bar.dart';
import 'package:ajanchat/pages/tabs/chat/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({Key? key}) : super(key: key);

  @override
  _SingleChatPageState createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  @override
  Widget build(BuildContext context) {

    dynamic chatContent = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: ChatAppBar(chatContent: chatContent),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ChatBubble(isSender: true, message: 'Bonjour', relationType: chatContent.relationType),
                  ChatBubble(isSender: false, message: 'Bonjour comment tu vas ?', relationType: chatContent.relationType),
                  ChatBubble(isSender: true, message: "On s'en bat les nibards de ça. Tu passes ce soir ?", relationType: chatContent.relationType),
                  ChatBubble(isSender: true, message: "😘😘😘", relationType: chatContent.relationType),
                  ChatBubble(isSender: false, message: "Quelle heure ? Je prépare une suprise pour toi.", relationType: chatContent.relationType),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(icon: SvgPicture.asset("assets/icons/heart.svg"), onPressed: () => print('Show emoji keyboard')),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.65,
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: false,
                        hintText: 'Hint Text',
                        hintStyle: TextStyle(color: Colors.black),
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(icon: SvgPicture.asset("assets/icons/camera.svg"), onPressed: () => print('show gallery to choose picture')),
                            IconButton(icon: SvgPicture.asset("assets/icons/voice.svg"), onPressed: () => print('record voice message')),
                          ],),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color: Colors.grey, width: 1.0, style: BorderStyle.solid))
                    ),
                  ),
                ),
                IconButton(icon: SvgPicture.asset("assets/icons/send.svg"), onPressed: () => print('send message'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

