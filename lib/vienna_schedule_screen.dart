import 'package:flutter/material.dart';
import 'vienna_task_detail.dart';

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
        useMaterial3: true,
      ),
      home: const CleaningScheduleScreen(),
    );
  }
}

class CleaningScheduleScreen extends StatefulWidget {
  const CleaningScheduleScreen({super.key});

  @override
  State<CleaningScheduleScreen> createState() => _CleaningScheduleScreenState();
}

class _CleaningScheduleScreenState extends State<CleaningScheduleScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Anna, good day',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Monday, November 2, 2026',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text('AN', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D47A1),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Current cleaning',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.pause, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text('In progress', style: TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn('Start time', '11:30 AM'),
                        _buildInfoColumn('Schedule', '2 hours'),
                        _buildInfoColumn('Completed', '1 of 3'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF0D47A1),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
                        );
                      },
                      icon: const Icon(Icons.play_arrow_outlined),
                      label: const Text('Open cleaning', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Cleaning Schedule',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    '3 apartments',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildJobCard(
                context: context,
                time: '09:00–11:00 · 2 h',
                address: 'Apartment Mariahilfer Str. 45, Apt. 12',
                group: 'District "Zentrum"',
                statusWidget: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: const [
                      Icon(Icons.check, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('Photos sent', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              _buildJobCard(
                context: context,
                time: '11:30–13:30 · 2 h',
                address: 'Apartment Praterstraße 23, Apt. 8',
                group: 'District "Zentrum"',
                isCurrent: true,
                statusWidget: Row(
                  children: const [
                    Icon(Icons.pause, size: 14, color: Color(0xFF0D47A1)),
                    SizedBox(width: 4),
                    Text('In progress', style: TextStyle(fontSize: 12, color: Color(0xFF0D47A1), fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              _buildJobCard(
                context: context,
                time: '14:00–16:00 · 2 h',
                address: 'Apartment Schönbrunner Str. 112, Apt. 4',
                group: 'District "Nord"',
                statusWidget: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: const [
                      Icon(Icons.access_time, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('Scheduled', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                bottomAction: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('On schedule · 2 h', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
                        );
                      },
                      icon: const Icon(Icons.play_arrow_outlined, size: 18),
                      label: const Text('On schedule'),
                      style: TextButton.styleFrom(foregroundColor: const Color(0xFF0D47A1)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.sync, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        'Synced at 12:30 PM',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 3) { // Если нажали на вкладку Отчёты
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ReportsScreen()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), activeIcon: Icon(Icons.calendar_month), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildJobCard({
    required BuildContext context,
    required String time,
    required String address,
    required String group,
    required Widget statusWidget,
    bool isCurrent = false,
    Widget? bottomAction,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isCurrent ? const Color(0xFFEEF2FA) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isCurrent ? Border.all(color: const Color(0xFF0D47A1).withOpacity(0.3), width: 1) : null,
        boxShadow: !isCurrent
            ? [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(time, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                    statusWidget,
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 4),
                          Text(group, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
                if (bottomAction != null) ...[
                  const Divider(height: 24, thickness: 0.5),
                  bottomAction,
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
