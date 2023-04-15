import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          ListTile(
            title: const Text('Ubicación'),
            onTap: () => Navigator.pushNamed(context, 'ubicacion'),
          ),
        ],
      ),
    );
  }
}
