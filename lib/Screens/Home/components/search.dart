import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SearchBar extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          Navigator.pop(context);
        });
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Report> temp = [];
    List<Report> _seach = List<Report>();
    List<Report> _seachForDisplay = List<Report>();
    downloadJSON().then((value) {
      _seach.addAll(value);
      _seachForDisplay = _seach;
    });
    temp.addAll(
        _seachForDisplay.where((element) => element.title.contains(query)));
    return ListView.builder(
        itemCount: temp.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(temp[index].title),
          );
        });
    throw UnimplementedError();
  }
}
