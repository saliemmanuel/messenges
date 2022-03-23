import 'package:flutter/material.dart';
import 'package:messenger_app/core/utils/app_export.dart';
import 'package:messenger_app/vue/chat_screen/models/chat_model.dart';

class HomeCard extends StatelessWidget {
  final ChatModel? item;
  final Color? color;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  const HomeCard({Key? key, this.item, this.onTap, this.onLongPress, required  this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(left: 5.0,right: 5.0,bottom: 5.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: ColorConstant.whiteA700,
          borderRadius: BorderRadius.circular(getHorizontalSize(8.0)),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              height: 50.0,
              width: 50.0,
              color: color,
              alignment: Alignment.center,
              child: Text(item!.title!.substring(0,1),   style: TextStyle(
                color: ColorConstant.whiteA700,
                fontSize: getFontSize(20),
                fontFamily: 'General Sans',

                fontWeight: FontWeight.w500,
              ),),
            )
          ),
          title: Text(
            item!.title!,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: ColorConstant.gray900,
              fontSize: getFontSize(16),
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            item!.lastMessage! ,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: ColorConstant.bluegray400,
              fontSize: getFontSize(14),
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Text(
            item!.date!,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: ColorConstant.bluegray400,
              fontSize: getFontSize(14),
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
