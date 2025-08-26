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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final user = Supabase.instance.client.auth.currentUser;
    final userName = user?.userMetadata?['full_name'] ?? "User";

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: AppBar(
        backgroundColor: appWhiteColor,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notifications not implemented yet')),
              );
            },
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
                    radius: screenWidth * 0.08,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(userName, style: AppFonts.textStyle16),
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
                  Text("Home", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () {
                GoRouter.of(context).go(AppRoutes.kHome);
                Navigator.pop(context);
              },
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
                  Text("Profile", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () {
                GoRouter.of(context).go(AppRoutes.kNav);
                setState(() => _selectedIndex = 2); // Switch to Profile tab
                Navigator.pop(context);
              },
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
                  Text("Favorite", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () {
                GoRouter.of(context).go(AppRoutes.kNav);
                setState(() => _selectedIndex = 1); // Switch to Favorite tab
                Navigator.pop(context);
              },
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
                  Text("Settings", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Settings not implemented yet')),
                );
                Navigator.pop(context);
              },
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
                  Text("Logout", style: AppFonts.textStyle18),
                ],
              ),
              onTap: () async {
                try {
                  await Supabase.instance.client.auth.signOut();
                  GoRouter.of(context).go(AppRoutes.kLogin);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged out successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error logging out: $e')),
                  );
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: widgetOptions[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.01,
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
