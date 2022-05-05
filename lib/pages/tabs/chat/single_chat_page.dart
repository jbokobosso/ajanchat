import 'package:ajanchat/constants/file_assets.dart';
import 'package:ajanchat/pages/tabs/chat/chat_app_bar.dart';
import 'package:ajanchat/pages/tabs/chat/chat_bubble.dart';
import 'package:ajanchat/providers/chat_provider.dart';
import 'package:ajanchat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({Key? key}) : super(key: key);

  @override
  _SingleChatPageState createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    dynamic chatContent = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: ChatAppBar(chatContent: chatContent),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(FileAssets.bg2), fit: BoxFit.cover)),
        child: Padding(
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
              Consumer<ChatProvider>(
                builder: (context, chatProvider, child) => Row(
                  children: [
                    IconButton(icon: SvgPicture.asset(FileAssets.heardIcon, width: 25.0,), onPressed: () => print('Show emoji keyboard')),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.67,
                      child: TextFormField(
                        controller: chatProvider.chatController,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Hint Text',
                            hintStyle: const TextStyle(color: Colors.black),
                            suffixIcon: Container(
                                padding: EdgeInsets.zero,
                                width: MediaQuery.of(context).size.width*0.10,
                                child: IconButton(icon: SvgPicture.asset(FileAssets.cameraIcon, width: 20.0,), onPressed: () => print('show gallery to choose picture'))
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color: Colors.grey, width: 1.0, style: BorderStyle.solid))
                        ),
                        onChanged: (value) => chatProvider.notifyForInputChange(),
                      ),
                    ),
                    chatProvider.chatController.text == ""
                        ? IconButton(icon: SvgPicture.asset(FileAssets.voiceIcon, width: 25.0,), onPressed: () => Utils.showToast("Record message"))
                        : IconButton(icon: SvgPicture.asset(FileAssets.sendIcon, width: 25.0,), onPressed: () => Utils.showToast("Send message"))
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

