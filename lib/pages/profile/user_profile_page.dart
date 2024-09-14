import 'package:flutter/material.dart';
import 'package:habit_sync_frontend/main.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_sync_frontend/providers/my_auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:habit_sync_frontend/services/navigation/router_constants.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
      appBar: AppBar(
        title: const Text("User Profile Page"),
        actions: [
          // Menú desplegable en el AppBar
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Lógica para el logout
                _signOut();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
