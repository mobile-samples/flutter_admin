import 'package:flutter/material.dart';
import 'package:flutter_admin/features/login/auth_model.dart';
import 'package:flutter_admin/features/home/home_provider.dart';
import 'package:flutter_admin/features/home/home.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key, required this.authInfo});
  final AuthInfo authInfo;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 1;
  @override
  void initState() {
    super.initState();
  }

  final List<Widget> screens = [
    const Scaffold(body: Center(child: Text('Search'))),
    const HomeScreen(),
    const Scaffold(body: Center(child: Text('Account'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()),
        ),
      ),
      body: AuthInheritedWidget(
        authData: widget.authInfo,
        child: Stack(
          children: screens
              .asMap()
              .map((i, screen) => MapEntry(
                  i,
                  Offstage(
                    offstage: selectedIndex != i,
                    child: screen,
                  )))
              .values
              .toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        currentIndex: selectedIndex,
        onTap: (i) => setState(() => selectedIndex = i,),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.search),
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
