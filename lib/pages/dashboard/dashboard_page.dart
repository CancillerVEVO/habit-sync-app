import 'package:flutter/material.dart';
import 'package:habit_sync_frontend/providers/my_auth_state.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_sync_frontend/services/navigation/router_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> _signOut() async {
    final authState = Provider.of<AuthStateProvider>(context, listen: false);
    ;
    try {
      await authState.signOut();
    } on AuthException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    } finally {
      if (mounted) {
        context.goNamed(RouteConstants.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to the Dashboard"),
            ElevatedButton(
              onPressed: () {
                _signOut();
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
