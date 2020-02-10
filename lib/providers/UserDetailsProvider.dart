import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nitorassignmentsolution/common/AppConstant.dart';
import 'package:nitorassignmentsolution/common/AppMethods.dart';

///UserDetailsItem is POJO class for storing the UserDetails information
class UserDetailsItem {
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
  final String name;
  final String company;
  final String blog;
  final String location;
  final String email;
  final bool hireable;
  final String bio;
  final int publicRepos;
  final int publicGists;
  final int followers;
  final int following;
  final String createdAt;
  final String updatedAt;

  UserDetailsItem({
    @required this.login,
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
    this.siteAdmin,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
    this.createdAt,
    this.updatedAt,
  });
}

///UserDetailsProvider will provide User Details data to UserDetails screen
class UserDetailsProvider with ChangeNotifier {
  UserDetailsItem _userDetails;

  UserDetailsProvider();

  /// Fetch user details data and set the ui
  Future<UserDetailsItem> fetchAndSetUserDetails(
      BuildContext context, String login) async {

    var url = AppConstant.url + "/users/$login";
    print(url);
    final response =
        await http.get(url).catchError((error) {
      print(error.toString());
      return null;
    });

    UserDetailsItem loadedUserDetails;
    try {
      final userData = json.decode(response.body);
      if (userData == null) {
        return null;
      }

      loadedUserDetails = UserDetailsItem(
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
        name: userData['name'],
        company: userData['company'],
        blog: userData['blog'],
        location: userData['location'],
        email: userData['email'],
        bio: userData['bio'],
        hireable: userData['hireable'],
        publicRepos: userData['public_repos'],
        publicGists: userData['public_gists'],
        followers: userData['followers'],
        following: userData['following'],
        createdAt: userData['created_at'],
        updatedAt: userData['updated_at'],
      );
    } catch (err) {
      print(err.toString());
      if (!AppMethods.isLoading) Navigator.pop(context);
      return null;
    }
    _userDetails = loadedUserDetails;
    notifyListeners();
    return _userDetails;
  }
}
