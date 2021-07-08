import 'dart:js';

import 'package:book_aviyan_final/models/book_model.dart';
import 'package:book_aviyan_final/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search App"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
    // final List<String> searchedItems = searchList
    //     .where((element) => element.toLowerCase().contains(query.toLowerCase()))
    //     .toList();

    // return ListView.builder(
    //     itemCount: searchedItems.length,
    //     itemBuilder: (context, index) {
    //       ListTile(
    //         title: Text(searchedItems[index]),
    //       );
    //     });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _bookProvider = Provider.of<BookProvider>(context);

    List<BookModel> _bookList = _bookProvider.books;
    final List<BookModel> suggestionsItems = _bookList
        .where((element) =>
            element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
        itemCount: suggestionsItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionsItems[index].title!),
          );
        });
  }
}
