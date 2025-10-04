import 'package:flutter/material.dart';
import 'package:flutter_reacpi_app/Uitls/colors.dart';
import 'package:flutter_reacpi_app/Views/Recpi_app.dart';
import 'package:flutter_reacpi_app/Views/favorite_screen.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  late final List<Widget> page;
  void initState() {
    page = [
      const AppRecpiHome(),
      const FavoriteScreen(),
      navBarpage(Iconsax.calendar5),
      navBarpage(Iconsax.setting_21),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 20,
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.kprimaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: AppColors.kprimaryColor,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar,
            ),
            label: 'Meal Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting_2,
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: page[selectedIndex],
    );
  }

  navBarpage(iconName) {
    return Center(
      child: Icon(
        iconName,
        size: 100,
        color: AppColors.kprimaryColor,
      ),
    );
  }
}
