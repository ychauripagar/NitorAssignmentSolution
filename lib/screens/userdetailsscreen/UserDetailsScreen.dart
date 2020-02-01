import 'package:flutter/material.dart';
import 'package:nitorassignmentsolution/common/AppMethods.dart';
import 'package:nitorassignmentsolution/providers/UserDetailsProvider.dart';
import 'package:nitorassignmentsolution/providers/UsersProvider.dart';

import 'FollowersAndFollowingScreen.dart';

class UserDetailsScreen extends StatelessWidget {
  static const routeName = '/userdetails';
  final UserDetailsItem _userDetailsItem;

  UserDetailsScreen(this._userDetailsItem);

  final UsersProvider _user = new UsersProvider();

  Widget profileOtherDetails() {
    return Container(
      width: double.maxFinite,
      child: Card(
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8,
            direction: Axis.vertical,
            children: <Widget>[
              SizedBox(
                height: 1,
              ),
              Text(
                "Bio :",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Text(
                _userDetailsItem.bio == null
                    ? "Not Available"
                    : _userDetailsItem.bio,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                "Public Repository :",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Text(
                _userDetailsItem.publicRepos == null
                    ? ""
                    : "${_userDetailsItem.publicRepos}",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                "Public Gists :",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Text(
                _userDetailsItem.publicGists == null
                    ? ""
                    : "${_userDetailsItem.publicGists}",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                "Updated at :",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Text(
                _userDetailsItem.updatedAt == null
                    ? ""
                    : _userDetailsItem.updatedAt,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                "Blog :",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Text(
                _userDetailsItem.blog == null ? "" : "${_userDetailsItem.blog}",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('getting user details');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Card(
            color: Colors.grey[100],
            child: ListView(
              primary: false,
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Align(
                  // alignment: Alignment.c,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(_userDetailsItem.avatarUrl),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text(
                    _userDetailsItem.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.black54,
                      size: 16,
                    ),
                    Text(
                      _userDetailsItem.location == null
                          ? "Not Available"
                          : _userDetailsItem.location,
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "${_userDetailsItem.followers} Followers",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      onPressed: () async {
                        if (!AppMethods.isLoading) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (buildContext) {
                                return AppMethods.loading;
                              });
                        }

                        List<UserItem> _followersUserItem =
                            await _user.fetchAndSetFollowers(
                                context, _userDetailsItem.login);

                        List<UserItem> _followingsUserItem =
                            await _user.fetchAndSetFollowing(
                                context, _userDetailsItem.login);

                        if (!AppMethods.isLoading) Navigator.pop(context);
                        if (_followersUserItem != null) {
                          AppMethods.openScreen(
                              context,
                              FollowersAndFollowingScreen(
                                  _followersUserItem,
                                  _followingsUserItem,
                                  _userDetailsItem.name,
                                  0),
                              false);
                        }
                      },
                    ),
                    Text("|"),
                    FlatButton(
                      child: Text(
                        "${_userDetailsItem.following} Following",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      onPressed: () async {
                        if (!AppMethods.isLoading) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (buildContext) {
                                return AppMethods.loading;
                              });
                        }

                        List<UserItem> _followersUserItem =
                            await _user.fetchAndSetFollowers(
                                context, _userDetailsItem.login);

                        List<UserItem> _followingsUserItem =
                            await _user.fetchAndSetFollowing(
                                context, _userDetailsItem.login);

                        if (!AppMethods.isLoading) Navigator.pop(context);
                        if (_followersUserItem != null) {
                          AppMethods.openScreen(
                              context,
                              FollowersAndFollowingScreen(
                                  _followersUserItem,
                                  _followingsUserItem,
                                  _userDetailsItem.name,
                                  1),
                              false);
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                profileOtherDetails(),
              ],
            )),
      ),
    );
  }
}
