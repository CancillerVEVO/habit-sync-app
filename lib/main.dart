import 'package:flutter/material.dart';
import 'package:habit_sync_frontend/pages/dashboard/dashboard_page.dart';
import 'package:habit_sync_frontend/pages/auth/login_page.dart';
import 'package:habit_sync_frontend/pages/auth/signup_page.dart';
import 'package:habit_sync_frontend/services/navigation/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  String supabaseUrl = dotenv.get('SUPABASE_URL');
  String supabaseKey = dotenv.get('SUPABASE_KEY');

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Habit Sync',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme
            .of(this)
            .colorScheme
            .error
            : Theme
            .of(this)
            .snackBarTheme
            .backgroundColor,
      ),
    );
  }
}
