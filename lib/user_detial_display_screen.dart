import 'package:flutter/material.dart';
import 'package:username_id/user_model_file.dart';


class DisplayUserDataScreen extends StatelessWidget {
  final User user;

  DisplayUserDataScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${user.username}'),
            Text('Email: ${user.email}'),
          ],
        ),
      ),
    );
  }
}
