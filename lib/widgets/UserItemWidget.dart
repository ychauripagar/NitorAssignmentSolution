import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/UsersProvider.dart';

class UserItemWidget extends StatefulWidget {
  final UserItem userItem;

  UserItemWidget(this.userItem);

  @override
  _UserItemWidgetState createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(

      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${widget.userItem.login}'),
            subtitle: Text(widget.userItem.id.toString()),
          ),
        ],
      ),
    );
  }
}
