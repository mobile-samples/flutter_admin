import 'package:flutter/material.dart';
import 'package:flutter_admin/features/auth/auth_model.dart';
import 'package:flutter_admin/features/home/home.dart';
import 'package:flutter_admin/features/role/widgets/role_list.dart';
import 'package:flutter_admin/features/user/widgets/user_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.authInfo});
  final AuthInfo authInfo;

  @override
  State<Dashboard> createState() => _NavbarState();
}

class _NavbarState extends State<Dashboard> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const RoleScreen(),
    const UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()),
        ),
      ),
      body: Center(
        child: screens.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: ''),
        ],
      ),
      drawer: const Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Drawer'),
            ],
          ),
        ),
      ),
      drawerEnableOpenDragGesture: false,
    );
  }
}
