import 'package:book_aviyan_final/presentation/gui/book_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:book_aviyan_final/data/models/book_model.dart';
import 'package:book_aviyan_final/presentation/feature/book_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSearch(context: context, delegate: DataSearch());
      },
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left:10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Search Books"),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<BookModel> suggestions = [];
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
    return Card(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _bookProvider = Provider.of<BookProvider>(context);

    List<BookModel> _bookList = _bookProvider.books;
    final List<BookModel> suggestionsItems = query.isEmpty
        ? suggestions
        : _bookList
            .where((element) =>
                element.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
        itemCount: suggestionsItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionsItems[index].title!),
            onTap: () {
              showResults(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDetailPage(bookDetail: BookModel(),)));
            },
          );
        });
  }
}
