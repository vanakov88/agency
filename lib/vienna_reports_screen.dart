import 'package:flutter/material.dart';
import 'vienna_schedule_screen.dart';
import 'vienna_task_detail.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _currentIndex = 3; // Вкладка "Reports" (Отчеты) активна
  bool _isDaily = true;
  String _selectedEmployee = 'Anna Smirnova';
  String _selectedDistrict = 'All Districts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Шапка
              Row(
                children: [
                  const Icon(Icons.clean_hands_outlined, color: Color(0xFF0D47A1), size: 18),
                  const SizedBox(width: 6),
                  Text(
                    'clean / team',
                    style: TextStyle(color: const Color(0xFF0D47A1), fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Reports',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Text(
                'Schedules, completed cleanings, and photo logs',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),

              // Переключатель Daily / Monthly
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isDaily = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _isDaily ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: _isDaily
                                ? [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Daily',
                              style: TextStyle(
                                fontWeight: _isDaily ? FontWeight.bold : FontWeight.normal,
                                color: _isDaily ? Colors.black87 : Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isDaily = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: !_isDaily ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: !_isDaily
                                ? [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Monthly',
                              style: TextStyle(
                                fontWeight: !_isDaily ? FontWeight.bold : FontWeight.normal,
                                color: !_isDaily ? Colors.black87 : Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Поля фильтров
              _buildFilterLabel('Date'),
              _buildFilterSelector(Icons.calendar_today_outlined, 'Monday, November 2, 2026'),
              const SizedBox(height: 14),

              _buildFilterLabel('Employee'),
              _buildDropdownFilter(['Anna Smirnova', 'John Doe', 'Max Mustermann'], _selectedEmployee, (val) {
                if (val != null) setState(() => _selectedEmployee = val);
              }),
              const SizedBox(height: 14),

              _buildFilterLabel('District'),
              _buildDropdownFilter(['All Districts', 'District "Zentrum"', 'District "Nord"'], _selectedDistrict, (val) {
                if (val != null) setState(() => _selectedDistrict = val);
              }),
              const SizedBox(height: 20),

              // Кнопка: Сформировать отчет Excel
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Generating Excel report...')),
                  );
                },
                icon: const Icon(Icons.table_view_rounded),
                label: const Text('Generate Excel Report', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              const SizedBox(height: 28),

              // Раздел: Итоги дня
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Summary of the Day',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    'As of 12:30 PM · Nov 2',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard('Scheduled', '3 cleanings', '6 hours assigned', Colors.grey[100]!, Colors.black87),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard('Completed', '1 cleaning', '2 hours logged', const Color(0xFFEEF2FA), const Color(0xFF0D47A1)),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Микро-статусы в строчку
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMicroStatus('In progress · 1'),
                  _buildMicroStatus('Pending · 1'),
                  Text('Photo logs · 1', style: TextStyle(color: const Color(0xFF0D47A1), fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 24),

              // Список квартир в отчете
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Apartments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  Text('Anna Smirnova', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
              const SizedBox(height: 12),

              // Квартира 1 (Завершена)
              _buildReportApartmentCard(
                address: 'Mariahilfer Str. 45, Apt. 12',
                meta: 'District "Zentrum" · 09:00–11:00
Logged: 2 h',
                statusLabel: 'Completed',
                statusColor: Colors.grey[400]!,
                hasPhoto: true,
              ),

              // Квартира 2 (В работе)
              _buildReportApartmentCard(
                address: 'Praterstraße 23, Apt. 8',
                meta: 'District "Zentrum" · 11:30–13:30
Elapsed: 1 h · Plan: 2 h',
                statusLabel: 'In progress',
                statusColor: const Color(0xFF0D47A1),
                hasPhoto: false,
              ),

              // Квартира 3 (Запланирована)
              _buildReportApartmentCard(
                address: 'Schönbrunner Str. 112, Apt. 4',
                meta: 'District "Nord" · 14:00–16:00
Plan: 2 h',
                statusLabel: 'Scheduled',
                statusColor: Colors.grey[500]!,
                hasPhoto: false,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CleaningScheduleScreen()));
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), activeIcon: Icon(Icons.calendar_month), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Employees'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), activeIcon: Icon(Icons.bar_chart_rounded), label: 'Reports'),
        ],
      ),
    );
  }

  Widget _buildFilterLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 4),
      child: Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildFilterSelector(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: const TextStyle(fontSize: 15, color: Colors.black87)),
          Icon(icon, color: Colors.grey[500], size: 20),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(List<String> items, String currentVal, Function(String?) onChange) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentVal,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey[500]),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 15)),
            );
          }).toList(),
          onChanged: onChange,
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String mainValue, String subValue, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 13)),
          const SizedBox(height: 6),
          Text(mainValue, style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(subValue, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMicroStatus(String text) {
    return Text(text, style: TextStyle(color: Colors.grey[600], fontSize: 13));
  }

  Widget _buildReportApartmentCard({
    required String address,
    required String meta,
    required String statusLabel,
    required Color statusColor,
    required bool hasPhoto,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
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
                  style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(meta, style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.3)),
          if (hasPhoto) ...[
            const Divider(height: 20, thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.photo_library_outlined, size: 16, color: const Color(0xFF0D47A1)),
                const SizedBox(width: 4),
                Text(
                  'Photo log >',
                  style: TextStyle(color: const Color(0xFF0D47A1), fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
