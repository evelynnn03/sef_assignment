import 'package:flutter/material.dart';

class MakeAnnouncementScreen extends StatelessWidget {
  static const String routeName = '/make-announcement';
  const MakeAnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Make your announcement here'),
      ),
    );
  }
}
