import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nitorassignmentsolution/common/AppConstant.dart';

class UserItem {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;
  final String htmlUrl;
  final String followersUrl;
  final String followingUrl;
  final String gistsUrl;
  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;
  final String eventsUrl;
  final String receivedEventsUrl;
  final String type;
  final bool siteAdmin;

  UserItem(
      {@required this.login,
      @required this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin});
}

class Users with ChangeNotifier {
  List<UserItem> _users = [];

  Users();

  List<UserItem> get getUsers {
    return [..._users];
  }

  Future<void> fetchAndSetUsers() async {
    final response = await http.get(AppConstant.url + "/users");

    final List<UserItem> loadedUsers = [];
    final extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((userData) {
      loadedUsers.add(
        UserItem(
          id: userData['id'],
          login: userData['login'],
          avatarUrl: userData['avatar_url'],
        ),
      );
    });
    _users = loadedUsers;
    notifyListeners();
  }
}
