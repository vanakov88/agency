import 'package:flutter/material.dart';
import 'vienna_schedule_screen.dart'; // Импорт первого экрана

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        useMaterial3: true, // Важно для корректного отображения Material-иконок
      ),
      home: const CleaningScheduleScreen(), // Запуск главного экрана расписания
    );
  }
}
