import 'package:flutter/material.dart';

import 'vienna_schedule_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _currentIndex = 3; // Индекс вкладки "Отчёты"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Reports',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Schedule, completed cleanings and photo logs',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 16),

              // Переключатель: Дневной / Месячный
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Daily',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Center(
                          child: Text(
                            'Monthly',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Поля фильтров (Дата, Сотрудник, Группа)
              _buildFilterField(
                'Date',
                'November 2, 2026, Monday',
                trailingIcon: Icons.calendar_today_outlined,
              ),
              _buildFilterField(
                'Employee name',
                'Anna Smirnova',
                trailingIcon: Icons.keyboard_arrow_down,
              ),
              _buildFilterField(
                'Apartment group',
                'All groups',
                trailingIcon: Icons.keyboard_arrow_down,
              ),
              const SizedBox(height: 16),

              // Кнопка генерации Excel
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                icon: const Icon(Icons.table_view_outlined),
                label: const Text(
                  'Generate Excel Report',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 24),

              // Итоги дня
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Day results',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'As of 12:30 PM · Nov 2',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Scheduled',
                      count: '3 cleanings',
                      sub: '6 hours assigned',
                      color: const Color(0xFFF8F9FA),
                      textColor: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Completed',
                      count: '1 cleaning',
                      sub: '2 hours logged',
                      color: const Color(0xFFEEF2FA),
                      textColor: const Color(0xFF0D47A1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Строка статусов текстом
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'In progress: 1',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    'Planned: 1',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    'Photo logs: 1',
                    style: TextStyle(
                      color: Color(0xFF0D47A1),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Раздел Квартиры
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Apartments',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Anna Smirnova',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Список карточек квартир для отчёта
              _buildReportApartmentCard(
                time: 'District: Zentrum · 09:00–11:00',
                address: 'Mariahilfer Str. 45, Apt. 12',
                statusLabel: 'Completed',
                additionalInfo: 'Logged: 2 h',
                statusColor: Colors.grey,
                showPhotoLog: true,
              ),
              _buildReportApartmentCard(
                time: 'District: Zentrum · 11:30–13:30',
                address: 'Praterstraße 23, Apt. 8',
                statusLabel: 'In progress',
                additionalInfo: 'Elapsed: 1 h · Plan: 2 h',
                statusColor: const Color(0xFF0D47A1),
                showPhotoLog: false,
              ),
              _buildReportApartmentCard(
                time: 'District: Nord · 14:00–16:00',
                address: 'Schönbrunner Str. 112, Apt. 4',
                statusLabel: 'Scheduled',
                additionalInfo: 'Plan: 2 h',
                statusColor: Colors.grey,
                showPhotoLog: false,
              ),
            ],
          ),
        ),
      ),

      // Навигационная панель
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0 || index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CleaningScheduleScreen(),
              ),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
        ],
      ),
    );
  }

  // Виджет для полей фильтрации
  Widget _buildFilterField(
    String label,
    String value, {
    required IconData trailingIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                Icon(trailingIcon, color: Colors.grey, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Виджет карточки итогов (виджеты сверху)
  Widget _buildSummaryCard({
    required String title,
    required String count,
    required String sub,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  // Исправленный метод для построения карточек квартир
  Widget _buildReportApartmentCard({
    required String time,
    required String address,
    required String statusLabel,
    required String additionalInfo,
    required Color statusColor,
    required bool showPhotoLog,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                additionalInfo,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              if (showPhotoLog)
                TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: const Color(0xFF0D47A1),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.image_outlined, size: 14),
                  label: const Text(
                    'Photo log >',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
