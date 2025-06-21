import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_task_page.dart';
// import 'package:taskly_app/widgets/bottom_navigation_bar.dart';

// If the Task class does not exist, define it here for demonstration:
class Task {
  final String id;
  final String title;
  final DateTime dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
  });
}

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({super.key});

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  List<Task> allTasks = []; // Example task data

  @override
  void initState() {
    super.initState();
    _loadAllTasks();
  }

  void _loadAllTasks() {
    // Mock data for demonstration
    setState(() {
      allTasks = [
        Task(
            id: '1',
            title: 'Tugas Agile',
            dueDate: DateTime(2025, 9, 5),
            isCompleted: false),
        Task(
            id: '2',
            title: 'Laporan Praktikum DKA',
            dueDate: DateTime(2025, 9, 6),
            isCompleted: false),
        Task(
            id: '3',
            title: 'Menyiram Tanaman',
            dueDate: DateTime(2025, 9, 6),
            isCompleted: false),
        Task(
            id: '4',
            title: 'Belanja Bulanan',
            dueDate: DateTime(2025, 9, 7),
            isCompleted: false),
        Task(
            id: '5',
            title: 'Rapat Komunitas',
            dueDate: DateTime(2025, 9, 8),
            isCompleted: false),
        Task(
            id: '6',
            title: 'Ulang tahun nenek',
            dueDate: DateTime(2025, 9, 23),
            isCompleted: false),
        Task(
            id: '7',
            title: 'Sempro Kak Putri',
            dueDate: DateTime(2025, 9, 25),
            isCompleted: false),
        Task(
            id: '8',
            title: 'Foto studio keluarga',
            dueDate: DateTime(2025, 9, 29),
            isCompleted: false),
        Task(
            id: '9',
            title: 'Kunjungan panti',
            dueDate: DateTime(2025, 9, 29),
            isCompleted: false),
        Task(
            id: '10',
            title: 'Praktik Industri',
            dueDate: DateTime(2025, 10, 2),
            isCompleted: false),
        Task(
            id: '11',
            title: 'Jurnal Kegiatan',
            dueDate: DateTime(2025, 10, 6),
            isCompleted: false),
      ];
    });
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      // In a real app, you would update this in your database/service
    });
  }


  @override
  Widget build(BuildContext context) {
    // Separate tasks into overdue and in-progress
    final DateTime now = DateTime.now();
    final List<Task> overdueTasks = allTasks.where((task) =>
        !task.isCompleted && task.dueDate.isBefore(DateTime(now.year, now.month, now.day))).toList();
    final List<Task> inProgressTasks = allTasks.where((task) =>
        !task.isCompleted && (task.dueDate.isAfter(DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1))) || task.dueDate.isAtSameMomentAs(DateTime(now.year, now.month, now.day)))).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Semua Tugas',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (overdueTasks.isNotEmpty) ...[
              const Text(
                'Terlambat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              // Overdue Tasks List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: overdueTasks.length,
                itemBuilder: (context, index) {
                  final task = overdueTasks[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => _toggleTaskCompletion(task),
                            child: Icon(
                              task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                                    color: task.isCompleted ? Colors.grey : Colors.black,
                                  ),
                                ),
                                Text(
                                  DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(task.dueDate), // Format for Indonesian
                                  style: const TextStyle(fontSize: 12, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
            const Text(
              'Dalam Proses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // In-Progress Tasks List
            Expanded(
              child: ListView.builder(
                itemCount: inProgressTasks.length,
                itemBuilder: (context, index) {
                  final task = inProgressTasks[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => _toggleTaskCompletion(task),
                            child: Icon(
                              task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                                    color: task.isCompleted ? Colors.grey : Colors.black,
                                  ),
                                ),
                                Text(
                                  DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(task.dueDate),
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        elevation: 2.0,
        child: const Icon(Icons.add, color: Colors.white, size: 36),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   selectedIndex: _selectedIndex,
      //   onItemTapped: _onItemTapped,
      // ),
    );
  }
}
