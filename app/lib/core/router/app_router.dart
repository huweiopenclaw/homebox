import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/box/presentation/pages/add_box_page.dart';
import '../../features/box/presentation/pages/box_detail_page.dart';
import '../../features/box/presentation/pages/box_list_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  login,
  register,
  boxes,
  boxDetail,
  addBox,
  chat,
  settings,
}

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: AppRoute.register.name,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/boxes',
        name: AppRoute.boxes.name,
        builder: (context, state) => const BoxListPage(),
      ),
      GoRoute(
        path: '/boxes/:id',
        name: AppRoute.boxDetail.name,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BoxDetailPage(boxId: id);
        },
      ),
      GoRoute(
        path: '/add-box',
        name: AppRoute.addBox.name,
        builder: (context, state) => const AddBoxPage(),
      ),
      GoRoute(
        path: '/chat',
        name: AppRoute.chat.name,
        builder: (context, state) => const ChatPage(),
      ),
      GoRoute(
        path: '/settings',
        name: AppRoute.settings.name,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );
}
