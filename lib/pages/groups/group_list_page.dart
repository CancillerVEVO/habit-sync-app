import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_sync_frontend/services/navigation/router_constants.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group List Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.goNamed(RouteConstants.createGroup);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Group 1"),
            onTap: () {
              context.goNamed(RouteConstants.group, pathParameters: {'groupId': '1'});
            },
          ),
          ListTile(
            title: const Text("Group 2"),
            onTap: () {
              context.goNamed(RouteConstants.group, pathParameters: {'groupId': '2'});
            },
          ),
        ],
      ),
    );
  }
}
