import 'package:flutter/material.dart';
import 'package:nitorassignmentsolution/providers/UsersProvider.dart';
import 'package:nitorassignmentsolution/screens/UsersScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyNitorAssignmentApp());

class MyNitorAssignmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Users>(
      create: (_) => Users(),
      child: MaterialApp(
        title: 'Nitor Assignment',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: UsersScreen(),
        routes: {
          UsersScreen.routeName: (ctx) => UsersScreen(),
        },
      ),
    );
  }
}
