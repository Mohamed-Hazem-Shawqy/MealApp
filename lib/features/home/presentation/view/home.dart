import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final supabase = Supabase.instance.client;
              await supabase.auth.signOut();
              print('===============usr SignOut===============');
              GoRouter.of(context).go(AppRoutes.kLogin);
            },
            icon: Icon(Icons.logout_sharp),
          ),
        ],
      ),
    );
  }
}
