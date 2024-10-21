import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:wakutori/views/all_schedule.dart';
import 'package:wakutori/views/edit_all_schedule.dart';
import 'package:wakutori/views/home_view.dart';
import 'package:wakutori/views/no_line.dart';
import 'package:wakutori/views/setting.dart';
import 'views/login.dart';
import 'color_schemes.g.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      title: '滋賀大学軽音楽部 練習枠',
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (BuildContext context) => RouteMap(
          routes: {
            '/': (routeData) => const MaterialPage(child: Login()),
            '/mySchedule': (routeData) => const MaterialPage(child: HomeView()),
            '/noLine': (routeData) => const MaterialPage(child: NoLine()),
            '/allSchedule': (routeData) => const MaterialPage(child: AllSchedule()),
            '/setting': (routeData) => const MaterialPage(child: Setting()),
          }
        ),
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}