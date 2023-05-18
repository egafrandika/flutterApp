import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget{
  final Function(String) onSearch;

  const SearchWidget({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Cari walpaper disini..."
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.search
            ),
          )
        ],
      ),
    );
  }
}