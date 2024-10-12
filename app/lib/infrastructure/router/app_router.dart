import 'package:app/domain/constants/routes.dart';
import 'package:app/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: Routes.home.name,
    pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
  ),
]);
