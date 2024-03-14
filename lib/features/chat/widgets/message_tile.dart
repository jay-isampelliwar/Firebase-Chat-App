import 'package:flutter/material.dart';

import '../../../widget/app_text_field.dart';

class MessageInput extends StatelessWidget {
  const MessageInput(
      {required this.controller, required this.onSend, super.key});

  final VoidCallback onSend;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(hintText: "Message", controller: controller),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            shape: BoxShape.circle,
          ),
          child: Align(
            child: IconButton(
              onPressed: onSend,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
