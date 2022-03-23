import 'package:flutter/material.dart';

void pushNewpage(var page, context) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (c) => page));
void pushNewpageAndRemoveUntil(var page, context) =>
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => page), (route) => false);