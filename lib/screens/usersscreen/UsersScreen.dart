import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitorassignmentsolution/common/AppMethods.dart';
import 'package:nitorassignmentsolution/providers/UsersProvider.dart';
import 'package:provider/provider.dart';
import 'UserItemWidget.dart';

///Display Users List
class UsersScreen extends StatefulWidget {
  static const routeName = '/users';

  @override
  _UsersScreenState createState() {
    return _UsersScreenState();
  }
}

class _UsersScreenState extends State<UsersScreen> {
  TextEditingController _filter = new TextEditingController();
  int pageIndex = 0;

  ///for pagination
  List<UserItem> _filterUsers = new List();
  bool isCancelDisplayed = false;
  bool isNoRecordFound = false;

  @override
  void initState() {
    super.initState();
  }

  void _fetchUsers(int pageNumber) async {
    ///reset the records
    Provider.of<UsersProvider>(context, listen: false).resetRecords();

    ///default we are loading users
    _filterUsers.clear();
    var _users = await Provider.of<UsersProvider>(context, listen: false)
        .filterUsers(_filter.text, pageNumber);

    if (!AppMethods.isLoading) Navigator.pop(context);
    setState(() {
      _filterUsers = _users;

      if (_filterUsers.length == 0) {
        isNoRecordFound = true;
      } else {
        isNoRecordFound = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _UsersScreenState() {
    _filter.addListener(() {
      // TextField has lost focus
      if (_filter.text.isEmpty) {
        setState(() {
          pageIndex = 1;
          _filterUsers.clear();
          isCancelDisplayed = false;
          Provider.of<UsersProvider>(context, listen: false).resetRecords();
        });
      } else {
        setState(() {
          isCancelDisplayed = true;
        });
      }
    });
  }

  bool isLoading = false;

  ///load more date for pagination
  Future _loadData() async {
    // perform fetching data delay

    pageIndex = pageIndex + 1;
    print("loading more...");
    _filterUsers = await Provider.of<UsersProvider>(context, listen: false)
        .filterUsers(_filter.text, pageIndex);

    print("loaded users");
    setState(() {
      print('items: ${_filterUsers.length}');
      isLoading = false;
    });
  }

//
  @override
  Widget build(BuildContext context) {
    print('build..getting users...');

    //region searchUser
    final searchUser = TextFormField(
      controller: _filter,
      onChanged: (input) {
        isNoRecordFound = false;
      },
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (input) {
        FocusScope.of(context).unfocus();
        if (input.trim() == "") {
          return null;
        }

        ///show loading...
        if (!AppMethods.isLoading) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (buildContext) {
                return AppMethods.loading;
              });
        }

        print("input:::$input");
        pageIndex = 1;
        _fetchUsers(pageIndex);
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
        suffixIcon: isCancelDisplayed
            ? IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  Provider.of<UsersProvider>(context, listen: false)
                      .resetRecords();

                  _filterUsers.clear();
                  Future.delayed(Duration(milliseconds: 50)).then((_) {
                    _filter.clear();

                    FocusScope.of(context).unfocus();
                  });
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

    return Scaffold(
      body: Column(
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
          Expanded(
            ///NotificationListener used for pagination which listen for scroller position and notify
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    _filter.text.isNotEmpty) {
                  ///load data if maxScrollExtent reached
                  _loadData();

                  setState(() {
                    isLoading = true;
                  });
                  return true;
                }
                return false;
              },
              child: _filterUsers.length == 0
                  ? Center(
                      child: !isCancelDisplayed
                          ? Text(
                              'Search Github User',
                              style: TextStyle(fontSize: 21),
                            )
                          : Text(
                              isNoRecordFound ? 'No record Found' : "",
                              style: TextStyle(fontSize: 21),
                            ),
                    )
                  : ListView.builder(
                      primary: false,
                      itemCount: _filterUsers.length,
                      itemBuilder: (ctx, i) =>
                          UserItemWidget(_filterUsers[i], true),
                    ),
            ),
          ),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
