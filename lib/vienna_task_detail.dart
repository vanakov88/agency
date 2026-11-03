import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final List<Map<String, dynamic>> _checklist = [
    {'title': 'Dust all surfaces', 'isChecked': true},
    {'title': 'Vacuum the carpets', 'isChecked': true},
    {'title': 'Mop the floors', 'isChecked': true},
    {'title': 'Clean the kitchen and bathrooms', 'isChecked': false},
    {'title': 'Take out the trash', 'isChecked': false},
  ];

  @override
  Widget build(BuildContext context) {
    int completedCount = _checklist.where((item) => item['isChecked'] == true).length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            // Реализация возврата на первый экран
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Task',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFEEF2FA), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: const [
                Icon(Icons.pause, size: 14, color: Color(0xFF0D47A1)),
                SizedBox(width: 4),
                Text('In progress', style: TextStyle(color: Color(0xFF0D47A1), fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('November 2, 2026 · Regular cleaning', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 12),
                    const Text(
                      'Apartment Praterstraße 23,\nApt. 8',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.2),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Text('District: ', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text('Zentrum', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w500)),
                        SizedBox(width: 20),
                        Text('Plan: ', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text('2 hours', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.location_on_outlined, color: Colors.black54),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Praterstraße 23, Apt. 8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
                                SizedBox(height: 4),
                                Text('2nd floor · courtyard entrance', style: TextStyle(color: Colors.grey, fontSize: 13)),
                              ],
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.near_me_outlined, color: Color(0xFF0D47A1)), onPressed: () {}),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cleaning checklist', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                        Text('$completedCount of ${_checklist.length}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(width: 140, height: 3, decoration: BoxDecoration(color: const Color(0xFF0D47A1), borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _checklist.length,
                      separatorBuilder: (context, index) => const Divider(height: 1, thickness: 0.5),
                      itemBuilder: (context, index) {
                        final item = _checklist[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Checkbox(
                            value: item['isChecked'],
                            activeColor: const Color(0xFF0D47A1),
                            onChanged: (bool? value) {
                              setState(() {
                                _checklist[index]['isChecked'] = value;
                              });
                            },
                          ),
                          title: Text(
                            item['title'],
                            style: TextStyle(
                              fontSize: 15,
                              color: item['isChecked'] ? Colors.grey : Colors.black87,
                              decoration: item['isChecked'] ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_outlined),
                    label: const Text('Cleaning in progress', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: const Color(0xFFF8F9FA),
                      side: BorderSide.none,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.check_box_outlined, size: 20),
                    label: const Text('Finish cleaning', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
