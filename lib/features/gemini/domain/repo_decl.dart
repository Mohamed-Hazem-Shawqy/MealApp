
import 'package:flutter/material.dart';

abstract class RepoDecl {
  Future geminiChat(String text);
  void scrollToBottom(ScrollController scrollController);
}