import 'package:flutter/material.dart';


class ActivityStatsPage extends StatefulWidget {
  const ActivityStatsPage({super.key});

  @override
  State<ActivityStatsPage> createState() => _ActivityStatsPageState();
}

class _ActivityStatsPageState extends State<ActivityStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity Stats Page"),
      ),
    );
  }
}
