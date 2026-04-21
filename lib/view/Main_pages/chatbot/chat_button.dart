import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shaprofile/view/Main_pages/chatbot/message.dart';

import 'chat_home.dart';

class ChatBotButton extends StatefulWidget {
  @override
  _ChatBotButtonState createState() => _ChatBotButtonState();
}

class _ChatBotButtonState extends State<ChatBotButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  //

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void openChatBot() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ChatHome()));
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FloatingActionButton(
        onPressed: openChatBot,
        elevation: 10,
        child: Icon(Icons.chat, size: 28, color: Colors.blue),
      ),
    );
  }
}
