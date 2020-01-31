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
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(widget.userItem.avatarUrl),
              radius: 25,
            ),
            title: Text(
              '${widget.userItem.login}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                Expanded(child: Text('Id: ${widget.userItem.id.toString()}')),
                Expanded(
                    child: Text('Score: ${widget.userItem.id.toString()}')),
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
