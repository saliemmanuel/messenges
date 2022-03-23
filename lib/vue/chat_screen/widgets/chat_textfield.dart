import 'dart:async';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:messenger_app/core/utils/app_export.dart';
import 'package:messenger_app/vue/chat_screen/models/chat_model.dart';
import 'package:resonance/resonance.dart';

class ChatTextField extends StatefulWidget {
  final TextEditingController? controller;
  final ScrollController? scrollController;
  final ChatModel? item;
  final VoidCallback? onTapToSendMessage;
  final TextEditingController? messageTextField;

  const ChatTextField(
      {Key? key,
      required this.controller,
      required this.scrollController,
      required this.item,
      required this.onTapToSendMessage,
      required this.messageTextField})
      : super(key: key);

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  bool isEmpty = true;
  bool? showEmoji = false;
  bool? showReplayCard = false;
  String? messageToReplay = '';
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          setState(() {
            showEmoji = false;
          });
        }
      },
    );
    widget.controller!.addListener(() {
      if (widget.controller!.text.isNotEmpty) {
        setState(() {
          messageToReplay = widget.controller!.text;
          showReplayCard = true;
          widget.controller!.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorConstant.whiteA700E5,
      ),
      child: Column(
        children: [
          Visibility(
            visible: showReplayCard!,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade300.withOpacity(0.8),
              ),
              child: ListTile(
                leading: const Icon(Icons.reply_all_rounded, size: 18.0),
                title: Text(
                  messageToReplay!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: ColorConstant.black900.withOpacity(0.5),
                      fontSize: getFontSize(14),
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w500),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close, size: 18.0),
                  onPressed: () {
                    setState(() {
                      showReplayCard = false;
                    });
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: SizedBox(
        
                  child: Icon(
                      showEmoji!
                          ? Icons.emoji_emotions
                          : Icons.emoji_emotions_outlined,
                      color: ColorConstant.deepPurpleA200),
                ),
                       onTap: () {
                    setState(() {
                      vibration();
                      showEmoji = !showEmoji!;
                      if (showEmoji!) {
                        focusNode.unfocus();
                        focusNode.canRequestFocus = false;
                      } else {
                        focusNode.requestFocus();
                      }
                    });
                  },
              ),
              Container(
                width: getHorizontalSize(263),
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.only(left: 15.0),
                decoration: BoxDecoration(
                  color: ColorConstant.bluegray50,
                  borderRadius: BorderRadius.circular(getHorizontalSize(8)),
                ),
                child: CupertinoScrollbar(
                  child: TextField(
                    cursorColor: ColorConstant.deepPurpleA200,
                    minLines: 1,
                    maxLines: 3,
                    focusNode: focusNode,
                    scrollPhysics: const ScrollPhysics(),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    controller: widget.messageTextField,
                    onChanged: (value) => setState(() {
                      widget.messageTextField!.text.isNotEmpty
                          ? isEmpty = false
                          : isEmpty = true;
                    }),
                    decoration: InputDecoration(
                        hintText: 'Ecrire un message...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: ColorConstant.bluegray400,
                            fontSize: getFontSize(14),
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              InkWell(
                child: SizedBox(
                  height: getSize(24),
                  width: getSize(24),
                  child: Icon(IconlyBold.send,
                      color: ColorConstant.deepPurpleA200),
                ),
                onTap: widget.onTapToSendMessage!,
              )
            ],
          ),
          showEmoji! ? showEmojiPicker() : Container(),
        ],
      ),
    );
  }

  vibration() async {
    await Resonance.vibrate(duration: const Duration(milliseconds: 50));
  }

  Widget showEmojiPicker() {
    return SizedBox(
      height: 300.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CupertinoScrollbar(
          child: EmojiPicker(
            config: Config(
                columns: 7,
                emojiSizeMax: 31 * (Platform.isIOS ? 1.30 : 1.0),
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: Category.RECENT,
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                progressIndicatorColor: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                showRecentsTab: true,
                recentsLimit: 28,
                noRecentsText: 'No Recents',
                noRecentsStyle:
                    const TextStyle(fontSize: 20, color: Colors.black26),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL),
            onBackspacePressed: _onBackspacePressed,
            onEmojiSelected: (Category category, Emoji emoji) {
              _onEmojiSelected(emoji);
            },
          ),
        ),
      ),
    );
  }

  _onEmojiSelected(Emoji emoji) { vibration();
    widget.messageTextField!
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: widget.messageTextField!.text.length));
  }

  _onBackspacePressed() {
    widget.messageTextField!
      ..text = widget.messageTextField!.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: widget.messageTextField!.text.length));
  }
}
