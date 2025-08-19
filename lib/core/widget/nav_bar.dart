import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meal_app/core/utils/app_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/home/presentation/view/favorite_screen.dart';
import '../../features/home/presentation/view/home_screen.dart';
import '../../features/home/presentation/view/profile_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

class CustomNav extends StatefulWidget {
  static const String routeName = '/nav';

  @override
  State<CustomNav> createState() => _CustomNavState();
}

class _CustomNavState extends State<CustomNav> {
  int _selectedIndex = 0;

  final List<Widget> widgetOptions = [
    HomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // 👇 get screen width & height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: AppBar(
        backgroundColor: appWhiteColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: appBlueColor,
              size: screenWidth * 0.05,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: appBlueColor),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: screenWidth * 0.08, // responsive radius
                  ),
                  SizedBox(width: screenWidth * 0.03), // spacing
                  Text("user name", style: AppFonts.textStyle16),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: appBlueColor,
                    size: screenWidth * 0.06,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text("home", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.person_3_outlined,
                    color: appBlueColor,
                    size: screenWidth * 0.06,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text("profile", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.favorite_border_outlined,
                    color: appBlueColor,
                    size: screenWidth * 0.06,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text("favorite", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: appBlueColor,
                    size: screenWidth * 0.06,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text("setting", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: appBlueColor,
                    size: screenWidth * 0.06,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text("logout", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () {
                onPressed:
                () async {
                  final supabase = Supabase.instance.client;
                  await supabase.auth.signOut();
                  print('===============usr SignOut===============');
                  GoRouter.of(context).go(AppRoutes.kLogin);
                };
              },
            ),
          ],
        ),
      ),
      body: widgetOptions[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06, // instead of 25 fixed
          vertical: screenHeight * 0.01, // small responsive bottom padding
        ),
        child: GNav(
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          color: appBlueColor,
          iconSize: screenWidth * 0.07,
          // responsive icon size
          activeColor: Colors.white,
          tabBackgroundColor: appBlueColor,
          tabs: const [
            GButton(icon: Icons.home_outlined),
            GButton(icon: Icons.favorite_border_outlined),
            GButton(icon: Icons.person_2_outlined),
          ],
        ),
      ),
    );
  }
}
