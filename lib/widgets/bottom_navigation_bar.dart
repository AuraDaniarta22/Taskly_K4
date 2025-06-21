import 'package:flutter/material.dart';
// import 'package:taskly_app/pages/all_tasks_page.dart';
// If CompletedTasksPage is defined elsewhere, import the correct file here.
import '../pages/calendar_page.dart';
import '../pages/home_page.dart';
import '../pages/completed_tasks_page.dart'; // Make sure this path matches the actual location of CompletedTasksPage
import '../pages/settings_page.dart'; // Update this path and filename to match your actual settings page file

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(0, Icons.home, 'Home', context),
          _buildNavItem(1, Icons.calendar_today, 'Kalender', context),
          const SizedBox(width: 48), // Space for the FAB
          _buildNavItem(2, Icons.access_time, 'Waktu', context), // Placeholder for History/Completed Tasks
          _buildNavItem(3, Icons.settings, 'Pengaturan', context),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, String label, BuildContext context) {
  // Ukuran default icon
  double iconSize = 24.0;
  // Jika index 0 (Home), perbesar 5%
  if (index == 0) {
    iconSize *= 1.05;
  }

    return Expanded(
      child: InkWell(
        onTap: () {
          onItemTapped(index);
          // Navigate based on the index
          switch (index) {
            case 0:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
              break;
            case 1:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CalendarPage()),
                (route) => false,
              );
              break;
            case 2:
              // For now, let's navigate to the Completed Tasks page when tapping the "Waktu" icon
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CompletedTasksPage()),
                (route) => false,
              );
              break;
            case 3:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
                (route) => false,
              );
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: iconSize,
              color: selectedIndex == index ? Theme.of(context).primaryColor : Colors.grey,
            ),
            // Text(
            //   label,
            //   style: TextStyle(
            //     color: selectedIndex == index ? Theme.of(context).primaryColor : Colors.grey,
            //     fontSize: 10,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}


