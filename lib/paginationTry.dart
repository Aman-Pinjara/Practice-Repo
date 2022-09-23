import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  const Pagination({Key? key}) : super(key: key);

  @override
  State<Pagination> createState() => PaginationState();
}

class PaginationState extends State<Pagination> {
  late ScrollController _scrollController;
  List<PageModel> myPageList = [];
  int curPage = 0;
  bool isLoading = true;
  final int itemsPerPage = 12;
  final int maxElements = 100;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    fetchMore();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        if (!isLoading && myPageList.length < maxElements) fetchMore();
      }
    });
  }

  void fetchMore() async {
    setState(() {
      isLoading = true;
    });
    curPage++;
    final String Url =
        "https://jsonplaceholder.typicode.com/posts?_page=$curPage&_limit=$itemsPerPage";
    final response = await get(Uri.parse(Url));
    List myList = json.decode(response.body);
    List<PageModel> newList = myList
        .map((e) => PageModel(id: e["id"], title: e["title"]!, des: e["body"]!))
        .toList();
    setState(() {
      myPageList.addAll(newList);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List try"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          myPageList.clear();
          curPage = 0;
          isLoading = true;
          fetchMore();
        },
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: myPageList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < myPageList.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.grey[200],
                trailing: Text(myPageList[index].id.toString()),
                title: Text(myPageList[index].title),
                subtitle: Text(myPageList[index].des),
              ),
            );
          } else if (myPageList.length >= maxElements) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "$maxElements items loaded successfully",
                style: const TextStyle(color: Colors.blue),
              )),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

class PageModel {
  final int id;
  final String title;
  final String des;

  PageModel({required this.id, required this.title, required this.des});
}
