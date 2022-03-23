import 'package:flutter/material.dart';
import 'package:messenger_app/core/utils/app_export.dart';
import 'package:messenger_app/core/helper/format_date.dart';
import 'package:messenger_app/vue/chat_screen/chat.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_advanced/sms_advanced.dart';
import '../chat_screen/models/chat_model.dart';
import 'widgets/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SmsQuery query = SmsQuery();
  List<SmsThread> getMessage = [];

  @override
  void initState() {
    super.initState();
    getAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade200,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: true,
                floating: true,
                expandedHeight: MediaQuery.of(context).size.height / 4.5,
                elevation: 0.0,
                forceElevated: false,
                primary: true,
                centerTitle: true,
                backgroundColor: Colors.grey.shade200,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Messages",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w100,
                          color: ColorConstant.black900,
                          fontFamily: 'General Sans')),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                    onPressed: () {},
                  )
                ],
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 90)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int i) {
                    final curentItem = ChatModel(
                      title: getMessage[i].contact?.fullName ??
                          getMessage[i].contact?.address,
                      lastMessage: getMessage[i].messages.first.body!,
                      date: FormatDate.formatDate(
                          getMessage[i].messages.first.date.toString()),
                      adress: getMessage[i].messages.first.address,
                    );
                    return HomeCard(
                        item: curentItem,
                        color: Colors.primaries[i + 22 % Colors.primaries.length],
                        onTap: () {
                          pushNewpage(
                              Chat(
                                item: curentItem
                              ),
                              context);
                        });
                  },
                  childCount: getMessage.isEmpty ? 0 : getMessage.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.deepPurpleA200,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Future getAllMessages() async {
    if (await Permission.contacts.request().isGranted ||
        await Permission.sms.request().isGranted ||
        await Permission.phone.request().isGranted) {
      SmsQuery query = SmsQuery();
      var messages = await query.getAllThreads;
      messages.forEach((element) async {
        getMessage.add(element);
        setState(() {});
      });
    } else {
      await Permission.contacts.request();
      await Permission.sms.request();
      await Permission.phone.request();
      setState(() {});
    }
  }
}
