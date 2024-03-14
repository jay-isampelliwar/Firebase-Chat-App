import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/helper.dart';

class ChatTile extends StatelessWidget {
  ChatTile({super.key, required this.isMe, required this.document});
  final DocumentSnapshot document;
  final bool isMe;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isMe ? Colors.white : Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Column(
        crossAxisAlignment: (document["senderId"] == _auth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            document["message"],
            style: TextStyle(
              color: isMe
                  ? Theme.of(context).colorScheme.onBackground
                  : Colors.white,
            ),
          ),
          Text(
            Helper.getFormattedTime(document["timestamp"]),
            style: TextStyle(
              fontSize: 10,
              color: isMe
                  ? Theme.of(context).colorScheme.onBackground
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
