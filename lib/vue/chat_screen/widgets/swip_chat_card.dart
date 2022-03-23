import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.dart';
import 'package:messenger_app/vue/chat_screen/models/chat_model.dart';
import 'package:resonance/resonance.dart';

import 'chat_card.dart';

class SwipChatCard extends StatefulWidget {
  final ChatModel? item;
  final TextEditingController? textEditingController;

  final bool? messageRecu;
  final String? haveReplayMessage;
  final String date;

  // final String? message;
  // final String? time;
  // final String? sim;
  // final String? statut;
  // final bool? messageRecu;
  // final bool? haveReplayMessage;
  // final TextEditingController? textEditingController;

  const SwipChatCard({
    Key? key,
    required this.messageRecu,
    required this.haveReplayMessage,
    required this.date,
    required this.item,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<SwipChatCard> createState() => _SwipChatCardState();
}

class _SwipChatCardState extends State<SwipChatCard> {
  double spaceBetween = 1.0;
  final _duration = const Duration(milliseconds: 200);
  final ScrollController? scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        _deleteScroll();
        if (scrollNotification is ScrollStartNotification) {
          _onStartScroll(scrollNotification.metrics);
        } else if (scrollNotification is ScrollEndNotification) {
          _onEndScroll(scrollNotification.metrics);
        }
        return true;
      },
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            AnimatedContainer(
                child: spaceBetween > 30
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.9),
                            child:
                                const Icon(Icons.reply, color: Colors.white)),
                      )
                    : const SizedBox(),
                duration: _duration,
                width: spaceBetween),
            ChatCard.name(
                item: widget.item,
                messageRecu: widget.messageRecu,
                haveReplayMessage: widget.haveReplayMessage,
                text: widget.item!.lastMessage,
                highlight: true,
                textEditingController: widget.textEditingController,
                date: widget.date),
            SizedBox(width: sideSize)
          ],
        ),
      ),
    );
  }

  _deleteScroll() {
    if (scrollController!.position.userScrollDirection ==
            ScrollDirection.forward ||
        scrollController!.position.userScrollDirection ==
            ScrollDirection.idle) {
      vibration();
    } else if (scrollController!.position.userScrollDirection ==
            ScrollDirection.forward ||
        scrollController!.offset != 0.0) {
      scrollController!.animateTo(0.0,
          duration: const Duration(microseconds: 1), curve: Curves.slowMiddle);
      vibration();
    }
  }

  _onStartScroll(ScrollMetrics metrics) {
    if (spaceBetween == 30.0) return;
    spaceBetween = 100.0;
    setState(() {});
    // if you need to do something at the start
  }

  _onEndScroll(ScrollMetrics metrics) {
    // do your magic here to return the value to normal
    spaceBetween = 1.0;
    setState(() {});
  }

  double sideSize = 5000000;
  vibration() async {
    await Resonance.vibrate(duration: const Duration(milliseconds: 8));
    setState(() {
      widget.textEditingController!.text = widget.item!.lastMessage!;
    });
  }
}
