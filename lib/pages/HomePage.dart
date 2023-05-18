
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/widget/FirstTab.dart';
import 'package:myapp/widget/SecondTab.dart';
// import 'package:myapp/widget/SearchWidget.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return DefaultTabController(length: 2, child: Scaffold(
      body: SafeArea(
        child: Column(children: [
          //Custom App Bar
          Container(
            margin: EdgeInsets.only(top: 6),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.menu,
                  size: 30,
                ),
                Text(
                  "Gambar Apik",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),

          //Search Widget next todo
          // SearchWidget(onSearch: (query) {

          // }),

          //Tab Bar
          TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 5),
            indicator: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1)),
            ),
            tabs: [
              Tab(text: "Setangah Gambar"),
              Tab(text: "Pemandangan"),
              // Tab(text: "next topic 2"),
              // Tab(text: "next topic 3"),
              // Tab(text: "next topic 4"),
              // Tab(text: "next topic 5"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                FirstTab(images: []),
                SecondTab(images: []),
                // ImagesWidget(images: []),
                // ImagesWidget(images: []),
                // ImagesWidget(images: []),
                // ImagesWidget(images: []),
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}