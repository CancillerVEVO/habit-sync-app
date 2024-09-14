import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_sync_frontend/pages/auth/login_page.dart';
import 'package:habit_sync_frontend/pages/auth/signup_page.dart';
import 'package:habit_sync_frontend/pages/dashboard/dashboard_page.dart';
import 'package:habit_sync_frontend/pages/groups/create_group_page.dart';
import 'package:habit_sync_frontend/pages/groups/group_list_page.dart';
import 'package:habit_sync_frontend/pages/groups/group_page.dart';
import 'package:habit_sync_frontend/pages/profile/user_profile_page.dart';
import 'package:habit_sync_frontend/pages/wrapper/main_wrapper_page.dart';
import 'package:habit_sync_frontend/providers/my_auth_state.dart';
import 'package:habit_sync_frontend/services/navigation/router_constants.dart';
import 'package:provider/provider.dart';

class AppRouter {
  AppRouter._();

  static const String _initialLocation = '/';

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorDashboardKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorProfileKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorGroupsKey = GlobalKey<NavigatorState>();

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: _initialLocation,
    debugLogDiagnostics: true,
    routes: [
      // MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          // Branch Dashboard
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDashboardKey,
            routes: <RouteBase>[
              // Dashboard
              GoRoute(
                path: '/',
                name: RouteConstants.dashboard,
                builder: (context, state) {
                  return DashboardPage();
                },
              ),
            ],
          ),

          // Branch Profile
          StatefulShellBranch(
              navigatorKey: _shellNavigatorProfileKey,
              routes: <RouteBase>[
                // Profile
                GoRoute(
                    path: '/profile',
                    name: RouteConstants.profile,
                    builder: (context, state) {
                      return UserProfilePage();
                    }),
              ]),

          // Branch Groups
          StatefulShellBranch(
              navigatorKey: _shellNavigatorGroupsKey,
              routes: <RouteBase>[
                GoRoute(
                    path: '/groups',
                    name: RouteConstants.groups,
                    builder: (context, state) {
                      return GroupListPage();
                    },
                    routes: [
                      GoRoute(
                          path: 'create',
                          name: RouteConstants.createGroup,
                          builder: (context, state) {
                            return const CreateGroupPage();
                          }),
                      // Group Detail
                      GoRoute(
                        path: ':groupId',
                        name: RouteConstants.group,
                        builder: (context, state) {
                          final String groupId = state.pathParameters['groupId']!;

                          return GroupPage(groupId: groupId);
                        },
                      ),
                      // Create Group
                    ]),
              ]),
        ],
      ),

      // Login
      GoRoute(
          path: '/login',
          name: RouteConstants.login,
          builder: (context, state) {
            return const LoginPage();
          }),
      // Signup
      GoRoute(
          path: '/signup',
          name: RouteConstants.signup,
          builder: (context, state) {
            return const SignupPage();
          }),
    ],
    redirect: (context, state) {
      final authState = Provider.of<AuthStateProvider>(context, listen: false);
      print(authState.currentSession?.user.id);
      final isLoggedIn = authState.currentSession?.user.id != null;
      final isLoggingIn = state.matchedLocation == '/login';
      final isSigningUp = state.matchedLocation == '/signup';

      // Si el usuario no está autenticado y está tratando de acceder a una página protegida
      if (!isLoggedIn) {
        if (!isLoggingIn && !isSigningUp) {
          return '/login';
        }
      }

      // Si el usuario está autenticado y trata de acceder a /login o /signup, redirige a /dashboard
      if (isLoggedIn) {
        if (isLoggingIn || isSigningUp) {
          return '/dashboard';
        }
      }

      // Si no hay redirección, retorna null
      return null;
    },
  );
}
