import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/home/bloc/nav_cubit.dart';
import '../features/home/bloc/theme_cubit.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class PortfolioApp extends StatelessWidget {
  PortfolioApp({super.key});

  final GoRouter _router = buildAppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => NavCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp.router(
            title: 'Omkar Mhatre — Senior Flutter Developer',
            debugShowCheckedModeBanner: false,
            themeMode: mode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
