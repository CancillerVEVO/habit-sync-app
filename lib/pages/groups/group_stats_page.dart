import 'package:flutter/material.dart';

class GroupStatsPage extends StatefulWidget {
  const GroupStatsPage({super.key});

  @override
  State<GroupStatsPage> createState() => _GroupStatsPageState();
}

class _GroupStatsPageState extends State<GroupStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Stats Page"),
      ),
    );
  }
}
