import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  final String groupId;

  const GroupPage({Key? key, required this.groupId}) : super(key: key);
  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Page xd"),
      ),
      body: Center(
        child: Text('Group ID: ${widget.groupId}'),
      ),
    );
  }
}
