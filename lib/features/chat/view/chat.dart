import 'package:chat_app/provider/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/message_item.dart';
import '../widgets/message_tile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.receiverUser, super.key});
  final DocumentSnapshot receiverUser;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUser.id, messageController.text.trim());
      messageController.clear();
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.receiverUser['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16, top: 8, left: 8, right: 8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _chatService.getMessages(
                    widget.receiverUser.id, _auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...");
                  }

                  return ListView(
                    controller: scrollController,
                    children: snapshot.data!.docs
                        .map(
                          (document) => MessageItem(
                            document: document,
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
            MessageInput(
              controller: messageController,
              onSend: sendMessage,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
