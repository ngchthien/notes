import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/pages/favorite_page.dart';
import 'package:notes_app/pages/list_note_page.dart';
import 'package:notes_app/pages/note_page.dart';
import 'package:notes_app/pages/search_page.dart';
import 'package:notes_app/pages/settings_page.dart';
import 'package:notes_app/models/note.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/notes',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomePage(navigationShell: navigationShell);
        },
        branches: [
          // Nhánh Ghi chú
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/notes',
                builder: (context, state) => const ListNotePage(),
              ),
            ],
          ),
          // Nhánh Quan trọng
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritePage(),
              ),
            ],
          ),
          // Nhánh Cài đặt
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/note',
        builder: (context, state) {
          final note = state.extra as Note?;
          return NotePage(note: note);
        },
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),
    ],
  );
});
