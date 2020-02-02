import 'package:flutter/material.dart';
import 'package:nitorassignmentsolution/common/AppMethods.dart';
import 'package:nitorassignmentsolution/screens/usersscreen/CustomAppBar.dart';
import 'package:nitorassignmentsolution/providers/UsersProvider.dart';
import 'package:nitorassignmentsolution/screens/usersscreen/UserItemWidget.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = '/users';

  @override
  Widget build(BuildContext context) {
    print('getting users');

    return Scaffold(
      body: Column(
        children: <Widget>[
          UserScreenAppBar(),
          Flexible(
            child: FutureBuilder(
              future: Provider.of<UsersProvider>(context, listen: false)
                  .fetchAndSetUsers(),
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return AppMethods.loading;
                } else {
                  if (dataSnapshot.error != null) {
                    // Do error handling stuff
                    print(dataSnapshot.error.toString());
                    return const Center(
                      child: Text('An error occurred!'),
                    );
                  } else {
                    return Consumer<UsersProvider>(
                      builder: (ctx, userData, child) =>
                          userData.getUsers.length == 0
                              ? Center(
                                  child: Text('No record found'),
                                )
                              : ListView.builder(
                                  primary: false,
                                  itemCount: userData.getUsers.length,
                                  itemBuilder: (ctx, i) => UserItemWidget(
                                      userData.getUsers[i], true),
                                ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
