import 'package:flutter/material.dart';
import 'package:posyandu/home/dashboard_page.dart';
import 'package:posyandu/home/userprofile.dart';
import 'package:posyandu/home/education.dart';
import 'package:posyandu/home/grafik.dart';
import 'package:posyandu/home/imunisasi.dart';
import 'package:posyandu/model/user.dart';

class NavigationButtom extends StatefulWidget {
  final User user;

  const NavigationButtom({super.key, required this.user});

  @override
  State<NavigationButtom> createState() => _NavigationButtomState();
}

class _NavigationButtomState extends State<NavigationButtom> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = <Widget>[
      const DashboardPage(),
      const Education(),
      const Grafik(),
      const Imunisasi(),
      Profile(user: widget.user),
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F6ECD),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _buildNavBarItem(Icons.home, "Home", 0),
            _buildNavBarItem(Icons.article, "Edukasi", 1),
            _buildNavBarItem(Icons.insert_chart, "Grafik", 2),
            _buildNavBarItem(Icons.medical_services, "Imunisasi", 3),
            _buildNavBarItem(Icons.person_3_outlined, "Profile", 4),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF0F6ECD),
          unselectedItemColor: const Color(0xFF0F6ECD),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? const Color(0xFF0F6ECD) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 25,
          color: _selectedIndex == index ? Colors.white : const Color(0xFF0F6ECD),
        ),
      ),
      label: label,
    );
  }
}