import 'package:flutter/material.dart';
import 'add_task_page.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../models/task.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int _selectedIndex = 1;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Task>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadTasksForCalendar();
  }

  void _loadTasksForCalendar() {
    // Dummy data
    final mockTasks = [
      Task(
        id: '1',
        title: 'Laporan Praktikum DKA',
        dueDate: DateTime(2025, 6, 9),
        dueTime: DateTime(2025, 6, 9, 23, 45),
      ),
      Task(
        id: '2',
        title: 'Menyiram Tanaman',
        dueDate: DateTime(2025, 6, 9),
        dueTime: DateTime(2025, 6, 9, 10, 00),
      ),
      Task(
        id: '3',
        title: 'Meeting dengan tim',
        dueDate: DateTime(2025, 9, 16),
        dueTime: DateTime(2025, 9, 16, 14, 00),
      ),
      Task(
        id: '4',
        title: 'Ulang tahun nenek',
        dueDate: DateTime(2025, 9, 23),
        isCompleted: true,
      ),
    ];

    // Group tasks by date
    Map<DateTime, List<Task>> newEvents = {};
    for (var task in mockTasks) {
      final date = DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);
      newEvents[date] = (newEvents[date] ?? [])..add(task);
    }
    setState(() {
      _events = newEvents;
    });
  }

  List<Task> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // TODO: Navigasi ke halaman lain jika diperlukan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Kalender',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TableCalendar<Task>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                headerPadding: const EdgeInsets.symmetric(vertical: 8.0),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.blue),
                rightChevronIcon: Icon(Icons.chevron_right, color: Colors.blue),
                titleTextFormatter: (date, locale) => DateFormat('dd MMMM yyyy').format(date),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.red[300],
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _getEventsForDay(_selectedDay!).length,
              itemBuilder: (context, index) {
                final task = _getEventsForDay(_selectedDay!)[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  color: Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd/MM/yyyy').format(task.dueDate),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (task.dueTime != null)
                              Text(
                                DateFormat('HH.mm WIB').format(task.dueTime!),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            const SizedBox(height: 4),
                            Text(
                              task.title,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Implement delete task functionality
                          },
                          child: const Text(
                            'Hapus',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
          floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddTaskPage()),
  );
          // TODO: Implement add task functionality or navigate to add task page when available.
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(), // <-- Tambahkan ini agar bulat sempurna
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 36), // (opsional, agar shadow sama)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}