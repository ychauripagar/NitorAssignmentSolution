import 'package:flutter/material.dart';
import 'package:nitorassignmentsolution/providers/UsersProvider.dart';
import 'package:nitorassignmentsolution/widgets/UserItemWidget.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = '/users';

  @override
  Widget build(BuildContext context) {
    print('getting users');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GitHub',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<Users>(context, listen: false).fetchAndSetUsers(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // Do error handling stuff
              print(dataSnapshot.error.toString());
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Users>(
                builder: (ctx, userData, child) => ListView.builder(
                  primary: false,
                  itemCount: userData.getUsers.length,
                  itemBuilder: (ctx, i) => UserItemWidget(userData.getUsers[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
