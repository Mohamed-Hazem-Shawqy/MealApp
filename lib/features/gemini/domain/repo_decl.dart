
import 'package:flutter/material.dart';

abstract class RepoDecl {
  Future<String> geminiChat(String text);
  void scrollToBottom(ScrollController scrollController);
}