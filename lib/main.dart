import 'package:flutter/material.dart';
// Обязательно проверьте имя файла расписания в вашей папке lib/ 
// Оно должно в точности совпадать с именем в импорте ниже:
import 'vienna_schedule_screen.dart'; 

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
        // Включаем поддержку Material-иконок на уровне темы приложения
        useMaterial3: true, 
      ),
      // Указываем первый экран приложения в качестве домашнего
      home: const CleaningScheduleScreen(), 
    );
  }
}
