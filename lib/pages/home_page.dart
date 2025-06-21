// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import 'add_task_page.dart';
import '../widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // For bottom navigation bar
  List<Task> todayTasks = []; // Example task data

  @override
  void initState() {
    super.initState();
    _loadTodayTasks();
  }

  void _loadTodayTasks() {
    // In a real app, you'd fetch this from a database or service.
    // For now, let's mock some data.
    setState(() {
      todayTasks = [
        Task(
            id: '1',
            title: 'Agile Prak 5',
            dueDate: DateTime.now(),
            dueTime: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 23, 59)),
        Task(
            id: '2',
            title: 'Web deadline malam ini',
            dueDate: DateTime.now(),
            dueTime: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 23, 59)),
        Task(
            id: '3',
            title: 'Sahur Keluarga',
            dueDate: DateTime.now(),
            dueTime: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 03, 30)),
        Task(
            id: '4',
            title: 'Bukber KKN',
            dueDate: DateTime.now(),
            dueTime: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 18, 00)),
      ];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigation handled within CustomBottomNavigationBar
  }

  void _navigateToAddTask() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    ).then((newTask) {
      if (newTask != null && newTask is Task) {
        // You would typically add this to your task list and save it
        // For this example, we'll just reload today's tasks
        _loadTodayTasks();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tugas berhasil ditambahkan!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Hide the default AppBar
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Cari...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tugas Hari ini',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(title: const Text('Semua Tugas')),
                          body: const Center(
                            child: Text('Halaman Semua Tugas belum diimplementasikan.'),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Lihat Semua..',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: todayTasks.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada tugas untuk hari ini.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: todayTasks.length,
                      itemBuilder: (context, index) {
                        final task = todayTasks[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0, // No shadow
                          color: Colors.blue[50], // Light blue background
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            child: Row(
                              children: [
                                Icon(
                                  task.isCompleted
                                      ? Icons.check_circle
                                      : Icons.radio_button_off,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    task.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: task.isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      color: task.isCompleted
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  task.dueTime != null
                                      ? DateFormat('HH.mm WIB').format(task.dueTime!)
                                      : '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
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
        onPressed: _navigateToAddTask,
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