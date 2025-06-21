import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_task_page.dart';
// Make sure the import path is correct and the Task class exists in this file.
import '../models/task.dart';
// import 'package:taskly_app/pages/add_task_page.dart';
import '../widgets/bottom_navigation_bar.dart';

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key});

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  int _selectedIndex = 2; // For bottom navigation bar (assuming "Waktu" is this page)
  List<Task> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadCompletedTasks();
  }

  void _loadCompletedTasks() {
    // Mock data for demonstration
    setState(() {
      completedTasks = [
        Task(
            id: '1',
            title: 'Laporan Praktikum DKA',
            dueDate: DateTime(2025, 9, 6),
            isCompleted: true),
        Task(
            id: '2',
            title: 'Menyiram Tanaman',
            dueDate: DateTime(2025, 9, 6),
            isCompleted: true),
        Task(
            id: '3',
            title: 'Belanja Bulanan',
            dueDate: DateTime(2025, 9, 7),
            isCompleted: true),
        Task(
            id: '4',
            title: 'Rapat Komunitas',
            dueDate: DateTime(2025, 9, 8),
            isCompleted: true),
        Task(
            id: '5',
            title: 'Ulang tahun nenek',
            dueDate: DateTime(2025, 9, 23),
            isCompleted: true),
        Task(
            id: '6',
            title: 'Sempro Kak Putri',
            dueDate: DateTime(2025, 9, 25),
            isCompleted: true),
        Task(
            id: '7',
            title: 'Foto studio keluarga',
            dueDate: DateTime(2025, 9, 29),
            isCompleted: true),
        Task(
            id: '8',
            title: 'Kunjungan panti',
            dueDate: DateTime(2025, 9, 29),
            isCompleted: true),
      ];
    });
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      // In a real app, you would update this in your database/service
      _loadCompletedTasks(); // Reload to reflect changes
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigation handled within CustomBottomNavigationBar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Riwayat Tugas',
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
        child: ListView.builder(
          itemCount: completedTasks.length,
          itemBuilder: (context, index) {
            final task = completedTasks[index];
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add task functionality or navigate to the correct page
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
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}