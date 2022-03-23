import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:messenger_app/core/utils/app_export.dart';
import 'package:messenger_app/vue/chat_screen/models/chat_model.dart';

class ChatCard extends StatelessWidget {
  final ChatModel? item;
  final TextEditingController? textEditingController;

  final bool? messageRecu;
  final String? haveReplayMessage;
  final String? text;
  final String date;
  final String? sender;
  final bool? highlight;

  const ChatCard.name({
    Key? key,
    required this.messageRecu,
    this.highlight,
    this.haveReplayMessage,
    this.text,
    this.sender,
    required this.date,
    required this.item,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 385,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            messageRecu! ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Visibility(
                visible: messageRecu!,
                replacement: const SizedBox(width: 75.0),
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorConstant.deepPurpleA200.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(25.0)),
                  margin: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Text(
                    item!.title!.substring(0, 1),
                    style: TextStyle(
                      color: ColorConstant.whiteA700,
                      fontSize: getFontSize(20),
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                        getSize(12), getSize(12), getSize(16), getSize(12)),
                    decoration: BoxDecoration(
                      color: messageRecu!
                          ? Colors.deepPurple.withOpacity(0.4)
                          : ColorConstant.whiteA700,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(getHorizontalSize(12)),
                        topRight: Radius.circular(getHorizontalSize(12)),
                        bottomLeft: Radius.circular(
                            getHorizontalSize(messageRecu! ? 3 : 12)),
                        bottomRight: Radius.circular(
                            getHorizontalSize(messageRecu! ? 12 : 3)),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        haveReplayMessage == null
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: getVerticalSize(4),
                                      left: getVerticalSize(4),
                                    ),
                                    child: Container(
                                      height: getVerticalSize(60),
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: messageRecu!
                                              ? Colors.deepPurple.shade100
                                              : ColorConstant.gray200,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: ListTile(
                                        title: Text(
                                          haveReplayMessage!,
                                          style: TextStyle(
                                            color: messageRecu!
                                                ? ColorConstant.whiteA700
                                                    .withOpacity(0.7)
                                                : ColorConstant.black900
                                                    .withOpacity(0.7),
                                            fontSize: getFontSize(14),
                                            fontFamily: 'SF Pro Text',
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        text == null
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: getVerticalSize(4),
                                    ),
                                    child: Text(
                                      text!,
                                      style: TextStyle(
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          height: 1.5,
                                          color: messageRecu!
                                              ? ColorConstant.whiteA700
                                              : ColorConstant.black900,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                        const Gap(5),
                        const SizedBox(
                          width: 5.0,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "  $date • ",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 10.0)),
                          messageRecu!
                              ? const TextSpan()
                              : const TextSpan(
                                  text: "Distribué • ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10.0)),
                          const TextSpan(
                              text: 'Orange',
                              style: TextStyle(
                                  color: Colors.purple, fontSize: 10.0))
                        ])),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
