import 'package:flutter/material.dart';
import 'package:flutter_application/bloc/counter_bloc.dart';
import 'package:flutter_application/data/constants.dart';
import 'package:flutter_application/data/notifiers.dart';
import 'package:flutter_application/views/widget_tree.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> initThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? repeat = prefs.getBool(KConstants.themeModeKey);
    isDarkModeNotifier.value = repeat ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return BlocProvider(
          create: (context) => CounterBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.teal,
                brightness: isDarkMode ? Brightness.dark : Brightness.light,
              ),
            ),
            home: WidgetTree(),
          ),
        );
      },
    );
  }
}
