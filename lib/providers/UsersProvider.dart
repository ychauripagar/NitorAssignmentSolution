import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nitorassignmentsolution/common/AppConstant.dart';
import 'package:nitorassignmentsolution/common/AppMethods.dart';

///UserItem is POJO class for storing the User information
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

///UsersProvider will provide User data to User screen
class UsersProvider with ChangeNotifier {
  List<UserItem> _filterUsers = [];

  UsersProvider();

  List<UserItem> get getUsers {
    return [..._filterUsers];
  }

  /// Filter users based on input search and
  /// set the ui with filtered data
  Future<List<UserItem>> filterUsers(String searchString, pageNo) async {
  var url = AppConstant.url + "/search/users?q=$searchString&page=$pageNo";
  print(url);
    final response = await http
        .get(url)
        .catchError((error) {
      print(error.toString());
      return null;
    });

    if (response != null && response.statusCode != 200) {
      throw HttpException("Failed to load users...${response.statusCode.toString()}");
    }

    final extractedData = json.decode(response.body);
    if (extractedData == null) {
      return null;
    }
    extractedData['items'].forEach((userData) {
      _filterUsers.add(
        UserItem(
          id: userData['id'],
          login: userData['login'],
          avatarUrl: userData['avatar_url'],
          nodeId: userData['node_id'],
          gravatarId: userData['gravatar_id'],
          url: userData['url'],
          htmlUrl: userData['html_url'],
          followersUrl: userData['followers_url'],
          followingUrl: userData['following_url'],
          gistsUrl: userData['gists_url'],
          starredUrl: userData['starred_url'],
          subscriptionsUrl: userData['subscriptions_url'],
          organizationsUrl: userData['organizations_url'],
          reposUrl: userData['repos_url'],
          eventsUrl: userData['events_url'],
          receivedEventsUrl: userData['received_events_url'],
          type: userData['type'],
          siteAdmin: userData['site_admin'],
        ),
      );
    });

    notifyListeners();
    return _filterUsers;
  }

  /// reset records on clear button clicked or
  /// searchString equal to empty
  void resetRecords() {
    _filterUsers.clear();
    //  notifyListeners();
  }

  /// Fetch followers data and set the ui
  Future<List<UserItem>> fetchAndSetFollowers(
      BuildContext context, String login) async {
    final response = await http
        .get(AppConstant.url + "/users/$login/followers")
        .catchError((error) {
      print(error.toString());
      return null;
    });
    final List<UserItem> loadedUsers = [];
    try {
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return null;
      }
      extractedData.forEach((userData) {
        loadedUsers.add(
          UserItem(
            id: userData['id'],
            login: userData['login'],
            avatarUrl: userData['avatar_url'],
            nodeId: userData['node_id'],
            gravatarId: userData['gravatar_id'],
            url: userData['url'],
            htmlUrl: userData['html_url'],
            followersUrl: userData['followers_url'],
            followingUrl: userData['following_url'],
            gistsUrl: userData['gists_url'],
            starredUrl: userData['starred_url'],
            subscriptionsUrl: userData['subscriptions_url'],
            organizationsUrl: userData['organizations_url'],
            reposUrl: userData['repos_url'],
            eventsUrl: userData['events_url'],
            receivedEventsUrl: userData['received_events_url'],
            type: userData['type'],
            siteAdmin: userData['site_admin'],
          ),
        );
      });
    } catch (err) {
      print(err.toString());
      if (!AppMethods.isLoading) Navigator.pop(context);
      return null;
    }

    return loadedUsers;
  }

  /// Fetch following data and set the ui
  Future<List<UserItem>> fetchAndSetFollowing(
      BuildContext context, String login) async {
    final response = await http
        .get(AppConstant.url + "/users/$login/following")
        .catchError((error) {
      print(error.toString());
      return null;
    });

    final List<UserItem> loadedUsers = [];
    try {
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return null;
      }
      extractedData.forEach((userData) {
        loadedUsers.add(
          UserItem(
            id: userData['id'],
            login: userData['login'],
            avatarUrl: userData['avatar_url'],
            nodeId: userData['node_id'],
            gravatarId: userData['gravatar_id'],
            url: userData['url'],
            htmlUrl: userData['html_url'],
            followersUrl: userData['followers_url'],
            followingUrl: userData['following_url'],
            gistsUrl: userData['gists_url'],
            starredUrl: userData['starred_url'],
            subscriptionsUrl: userData['subscriptions_url'],
            organizationsUrl: userData['organizations_url'],
            reposUrl: userData['repos_url'],
            eventsUrl: userData['events_url'],
            receivedEventsUrl: userData['received_events_url'],
            type: userData['type'],
            siteAdmin: userData['site_admin'],
          ),
        );
      });
    } catch (err) {
      print(err.toString());
      if (!AppMethods.isLoading) Navigator.pop(context);
      return null;
    }
    // _followings = loadedUsers;
    // notifyListeners();
    if (!AppMethods.isLoading) Navigator.pop(context);
    return loadedUsers;
  }
}
