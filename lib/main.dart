import 'package:flutter/material.dart';
import 'package:habit_sync_frontend/services/navigation/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_sync_frontend/providers/my_auth_state.dart';
import 'package:habit_sync_frontend/utils/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  String supabaseUrl = dotenv.get('SUPABASE_URL');
  String supabaseKey = dotenv.get('SUPABASE_KEY');

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  final supabaseClient = Supabase.instance.client;

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => AuthStateProvider(supabaseClient)),
      ],
      child: const MyApp(),
    ),
  );
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
      theme: ThemeData(
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        textTheme: GoogleFonts.robotoTextTheme(),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColors.text,
          unselectedItemColor: AppColors.text,
          backgroundColor: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          titleTextStyle: TextStyle(
            color: AppColors.text,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
