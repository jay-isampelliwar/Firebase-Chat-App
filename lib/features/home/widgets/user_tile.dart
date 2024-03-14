import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  const UserTile({required this.onTap, required this.user, super.key});
  final DocumentSnapshot user;
  final VoidCallback onTap;

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ScaleTransition(
        scale: _animation,
        child: Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            onTap: widget.onTap,
            title: Text(widget.user['name']),
            subtitle: Text(widget.user['email']),
            trailing: const Icon(Icons.chat),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
