import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/helper/format_date.dart';
import 'package:messenger_app/core/utils/app_export.dart';
import 'package:messenger_app/vue/home/home_screen.dart';
import 'package:resonance/resonance.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:telephony/telephony.dart';

import 'models/chat_model.dart';
import 'widgets/chat_textfield.dart';
import 'widgets/swip_chat_card.dart';

class Chat extends StatefulWidget {
  final ChatModel? item;
  const Chat({Key? key, required this.item}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var showEmoji = false;
  var controller = TextEditingController();
  var focusNode = FocusNode();
  var scrollChatCardScrollController = ScrollController();
  var chatTextFieldScrollController = ScrollController();
  var message = [];
  final TextEditingController? messageTextField = TextEditingController();
  var sizedHeigth = 80.0;
  @override
  void initState() {
    super.initState();
    getSpecifique(widget.item!.adress!);
    listener();
    // ce est fait pour augmenter la taile du sizedbox lorsqu'on veux replay un message.
    controller.addListener(() {
      if (controller.text.isNotEmpty) {
        setState(() {
          sizedHeigth = 200;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        leading: InkWell(
          onTap: () =>
              pushNewpageAndRemoveUntil(const HomeScreen(), context),
          child: Icon(CupertinoIcons.chevron_left,
              color: ColorConstant.black900, size: 20),
        ),
        elevation: 0.0,
        title: Text(
          widget.item!.title!,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ColorConstant.gray900,
              fontSize: getFontSize(16),
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: ColorConstant.black900,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: CupertinoScrollbar(
        child: Container(
          color: Colors.grey.shade200,
          child: Stack(
            children: [
              ListView(
                reverse: true,
                children: [
                  SizedBox(height: sizedHeigth),
                  ListView.separated(
                    controller: chatTextFieldScrollController,
                    reverse: true,
                    padding: const EdgeInsets.only(top: 10.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: message.isEmpty ? 0 : message.length,
                    itemBuilder: (_, i) {
                      return SwipChatCard(
                        textEditingController: controller,
                        item: ChatModel(
                          lastMessage: message[i]['body'],
                          adress: widget.item!.adress,
                          title: widget.item!.title,
                          date: FormatDate.formatDate(
                              message[i]["date"].toString()),
                        ),
                        haveReplayMessage: null,
                        messageRecu: message[i]['kind'].toString() ==
                                'SmsMessageKind.Received'
                            ? true
                            : false,
                        date: widget.item!.date!,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15.0),
                  ),
                ],
              ),
              Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: ChatTextField(
                    controller: controller,
                    messageTextField: messageTextField,
                    scrollController: chatTextFieldScrollController,
                    item: ChatModel(adress: widget.item!.adress!),
                    onTapToSendMessage: () {
                      sendSms(
                        message: controller,
                        number: widget.item!.adress,
                      );
                      message.clear();
                      getSpecifique(widget.item!.adress!);
                      message.add({
                        'address': widget.item!.adress,
                        'date': DateTime.now(),
                        'dateSent': DateTime.now(),
                        'id': "",
                        'isRead': "",
                        'onStateChanged': "",
                        'body': messageTextField!.text,
                        'kind': SmsQueryKind.Sent
                      });
                      messageTextField!.clear();

                      setState(() {});
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  var telephony = Telephony.instance;

  sendSms({var number, var message}) async {
    await telephony.sendSms(
        to: number,
        message: messageTextField!.text.isEmpty ? " " : messageTextField!.text);
    vibration();
  }

  vibration() async {
    await Resonance.vibrate(duration: const Duration(milliseconds: 50));
  }

  SmsQuery query = SmsQuery();

  getSpecifique(var adresse) async {
    var geta = await query.querySms(kinds: [
      SmsQueryKind.Sent,
      SmsQueryKind.Inbox,
      SmsQueryKind.Draft,
    ], address: adresse);
    geta.forEach((element) {
      Map data = {
        'address': element.address,
        'date': element.date,
        'dateSent': element.dateSent,
        'id': element.id,
        'isRead': element.isRead,
        'onStateChanged': element.onStateChanged,
        'body': element.body,
        'kind': element.kind
      };
      message.add(data);
      setState(() {});
    });
  }

  listener() {
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          setState(() {
            showEmoji = false;
          });
        }
      },
    );
  }
}
