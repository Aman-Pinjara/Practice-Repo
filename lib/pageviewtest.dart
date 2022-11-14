// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mytests/temppage/page1.dart';
import 'package:mytests/temppage/page2.dart';
import 'package:mytests/temppage/page3.dart';
import 'package:provider/provider.dart';

class PageViewTest extends StatefulWidget {
  const PageViewTest({super.key});

  @override
  State<PageViewTest> createState() => _PageViewTestState();
}

class _PageViewTestState extends State<PageViewTest> {
  bool lock = false;
  @override
  Widget build(BuildContext context) {

    PageController vert = PageController();
    PageController horz = PageController();
    return PageView(
      scrollDirection: Axis.vertical,
      physics: lock
          ? NeverScrollableScrollPhysics()
          : AlwaysScrollableScrollPhysics(),
      controller: vert,
      children: [
        PageView(
          onPageChanged: (value) {
            if (value == 1) {
              setState(() {
                lock = true;
              });
            } else {
              setState(() {
                lock = false;
              });
            }
          },
          controller: horz,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Page1(),
            Page2(),
          ],
        ),
        const Page3(),
      ],
    );
  }
}
