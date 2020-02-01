import 'package:flutter/material.dart';
import 'package:nitorassignmentsolution/common/AppMethods.dart';
import 'package:nitorassignmentsolution/providers/UserDetailsProvider.dart';
import 'package:nitorassignmentsolution/screens/userdetailsscreen/UserDetailsScreen.dart';

import '../../providers/UsersProvider.dart';

class UserItemWidget extends StatefulWidget {
  final UserItem userItem;
  final bool isUserScreen;

  UserItemWidget(this.userItem, this.isUserScreen);

  @override
  _UserItemWidgetState createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  UserDetails _userDetails = new UserDetails();

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
                widget.isUserScreen
                    ? Expanded(
                        child: Text('Score: ${widget.userItem.id.toString()}'))
                    : SizedBox(
                        height: 0,
                      ),
                widget.isUserScreen
                    ? IconButton(
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey[50],
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ),
                        ),
                        onPressed: () async {
                          UserDetailsItem _userDetailsItem = await _userDetails
                              .fetchAndSetUserDetails(widget.userItem.login);
                          if (_userDetailsItem != null) {
                            AppMethods.openScreen(context,
                                UserDetailsScreen(_userDetailsItem), false);
                          }
                        },
                      )
                    : SizedBox(
                        height: 0,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
