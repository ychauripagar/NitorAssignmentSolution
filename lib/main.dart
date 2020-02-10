import 'package:flutter/material.dart';
import 'package:nitorassignmentsolution/providers/UsersProvider.dart';
import 'package:provider/provider.dart';

import 'screens/usersscreen/UsersScreen.dart';

void main() {
  runApp(MyNitorAssignmentApp());
}

class MyNitorAssignmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsersProvider>(
      create: (_) => UsersProvider(),
      child: MaterialApp(
        title: 'Nitor Assignment',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: UsersScreen(),
      ),
    );
  }
}
