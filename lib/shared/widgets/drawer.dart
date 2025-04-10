import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vaani/features/you/view/server_manager.dart';
import 'package:vaani/router/router.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              'Vaani',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 30,
              ),
            ),
          ),
          ListTile(
            title: const Text('server Settings'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ServerManagerPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('App Settings'),
            onTap: () {
              context.goNamed(Routes.settings.name);
            },
          ),
        ],
      ),
    );
  }
}
