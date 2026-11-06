import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'vienna_schedule_screen.dart';
import 'vienna_chat_screen.dart';
import 'dart:html' as html; // Используется для скачивания файлов во Flutter Web

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _currentIndex = 3;
  bool _isGenerating = false;

  // Функция генерации и скачивания PDF на основе живых данных из Supabase
  Future<void> _generateAndDownloadPDF() async {
    setState(() => _isGenerating = true);

    try {
      // 1. Запрашиваем данные из живой базы PostgreSQL (Линейный срез за Ноябрь 2026)
      final List<dynamic> tasks = await Supabase.instance.client
          .from('cleaningtasks')
          .select('status, scheduled_start, scheduled_duration, actual_start, actual_end, apartments(address, district)')
          .order('scheduled_start', ascending: true);

      // 2. Создаем виртуальный PDF документ
      final pdf = pw.Document();

      // 3. Формируем страницу отчета
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              // Шапка документа
              pw.Text('CLEAN TEAM VIENNA · PERFORMANCE REPORT', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
              pw.SizedBox(height: 4),
              pw.Text('Monthly Summary Report · November 2026', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
              pw.SizedBox(height: 20),

              // Заголовок таблицы
              pw.Text('Detailed Cleaning Log', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),

              // Строим таблицу данных
              pw.TableHelper.fromTextArray(
                headers: ['Date', 'District / Address', 'Plan (h)', 'Actual (h)', 'Status'],
                data: tasks.map((task) {
                  final apt = task['apartments'] as Map<String, dynamic>? ?? {};
                  final startStr = task['scheduled_start']?.toString().split('T').first ?? '';
                  
                  // Расчет плановых часов
                  final int planMin = task['scheduled_duration'] ?? 0;
                  final double planHours = planMin / 60.0;

                  // Расчет фактических отработанных часов
                  double actualHours = 0.0;
                  if (task['actual_start'] != null && task['actual_end'] != null) {
                    final start = DateTime.parse(task['actual_start']);
                    final end = DateTime.parse(task['actual_end']);
                    actualHours = end.difference(start).inMinutes / 60.0;
                  }

                  return [
                    startStr,
                    '${apt['district'] ?? ''}\n${apt['address'] ?? ''}',
                    planHours.toStringAsFixed(2),
                    actualHours > 0 ? actualHours.toStringAsFixed(2) : '-',
                    task['status']?.toString().toUpperCase() ?? '',
                  ];
                }).toList(),
                border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.blue900),
                cellAlignment: pw.Alignment.centerLeft,
                cellPadding: const pw.EdgeInsets.all(6),
              ),
            ];
          },
        ),
      );

      // 4. Конвертируем документ в байты для сохранения в браузере
      final bytes = await pdf.save();
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      
      // 5. Инициируем скачивание файла у пользователя в вебе
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'vienna_cleaning_report_nov_2026.pdf')
        ..click();
      
      html.Url.revokeObjectUrl(url);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF Report downloaded successfully!')),
      );
    } catch (e) {
      print('PDF Generation Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating report: $e')),
      );
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Reports', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Schedule, completed cleanings and live PDF export', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 24),

              // Кнопка экспорта в PDF
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: _isGenerating ? null : _generateAndDownloadPDF,
                icon: _isGenerating 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.picture_as_pdf_outlined),
                label: Text(_isGenerating ? 'Generating PDF...' : 'Download PDF Report', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              const SizedBox(height: 24),

              const Text('Day results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildSummaryCard('Scheduled', '3 cleanings', '6 hours assigned', const Color(0xFFF8F9FA), Colors.black87)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildSummaryCard('Completed', '1 cleaning', '2 hours logged', const Color(0xFFEEF2FA), const Color(0xFF0D47A1))),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0 || index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CleaningScheduleScreen()));
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String count, String sub, Color color, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
