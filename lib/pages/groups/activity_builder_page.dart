import 'package:flutter/material.dart';

class ActivityBuilderPage extends StatefulWidget {
  const ActivityBuilderPage({super.key});

  @override
  State<ActivityBuilderPage> createState() => _ActivityBuilderPageState();
}

class _ActivityBuilderPageState extends State<ActivityBuilderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity Builder Page"),
      ),
    );
  }
}
