import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_posyandu/page/dashboard_page.dart';
import 'package:mobile_posyandu/page/userprofile.dart';
import 'package:mobile_posyandu/page/education.dart';
import 'package:mobile_posyandu/page/grafik.dart';
import 'package:mobile_posyandu/page/imunisasi.dart';
import 'package:mobile_posyandu/model/user.dart';

class NavigationButtom extends StatefulWidget {
  final UserData userData;
  const NavigationButtom({super.key, required this.userData});

  @override
  State<NavigationButtom> createState() => _NavigationButtomState();
}

class _NavigationButtomState extends State<NavigationButtom> {
  int _selectedIndex = 0;
  late PageController _pageController;
  late UserData userData;

  @override
  void initState() {
    super.initState();
    userData = widget.userData;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
        _pageController.jumpToPage(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          DashboardPage(userData: widget.userData),
          Education(userData: widget.userData),
          Grafik(userData: widget.userData),
          Imunisasi(userData: widget.userData),
          Profile(userData: widget.userData),
        ],
        onPageChanged: (index) {
          if (index != _selectedIndex) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF006BFA),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _buildNavBarItem(FontAwesomeIcons.house, "Home", 0),
            _buildNavBarItem(Icons.newspaper, "Edukasi", 1),
            _buildNavBarItem(FontAwesomeIcons.chartColumn, "Grafik", 2),
            _buildNavBarItem(FontAwesomeIcons.notesMedical, "Imunisasi", 3),
            _buildNavBarItem(Icons.person_sharp, "Profile", 4),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF006BFA),
          unselectedItemColor: const Color(0xFF006BFA),
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(_selectedIndex == index ? 12 : 8),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? const Color(0xFF006BFA) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 24,
          color: _selectedIndex == index ? Colors.white : const Color(0xFF006BFA),
        ),
      ),
      label: label,
    );
  }
}