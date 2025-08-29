import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meal_app/core/utils/app_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/gemini/presentation/views/chat_page.dart';
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
          // زر Chat
          IconButton(
            icon: Icon(CupertinoIcons.chat_bubble, color: appBlueColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatPage()),
              );
            },
          ),
          // زر Logout
          IconButton(
            icon: Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
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
            },
          ),
        ],
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
