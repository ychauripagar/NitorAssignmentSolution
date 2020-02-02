import 'package:flutter/material.dart';
import 'package:nitorassignmentsolution/providers/UsersProvider.dart';
import 'package:provider/provider.dart';

///Custom AppBar which display AppBar and search input.
class UserScreenAppBar extends StatefulWidget {
  @override
  _UserScreenAppBarState createState() => _UserScreenAppBarState();
}

class _UserScreenAppBarState extends State<UserScreenAppBar> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
//region searchUser
    final searchUser = TextFormField(
      controller: _filter,
      onTap: () {
        setState(() {
          _filter.text = "";
        });
      },
      autofocus: false,
      style: const TextStyle(fontSize: 15.0, color: Colors.black),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: new BorderRadius.circular(25),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: new BorderRadius.circular(25),
        ),
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
        ),
        suffixIcon: _filter.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  Provider.of<UsersProvider>(context, listen: false)
                      .resetRecords();
                },
              )
            : SizedBox(
                height: 0,
              ),
        fillColor: Colors.white,
        hintText: "Search User",
      ),
    );
    //endregion
    return Column(
      children: <Widget>[
        AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'GitHub',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Loto',
            ),
          ),
        ),
        Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: searchUser),
      ],
    );
  }

  _UserScreenAppBarState() {
    _filter.addListener(() {
      // TextField has lost focus

      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          Provider.of<UsersProvider>(context, listen: false).resetRecords();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          Provider.of<UsersProvider>(context, listen: false)
              .filterUsers(_searchText);
        });
      }
    });
  }
}
