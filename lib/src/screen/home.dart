import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/auth.dart';
import 'package:flutter_admin/src/providers/HomeProvider.dart';
import 'package:flutter_admin/src/screen/user/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthInfo authInfo;
  @override
  Widget build(BuildContext context) {
    authInfo = AuthInheritedWidget.of(context)!.authData;
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: _generateChildren(
                    authInfo.privileges.length, authInfo.privileges),
              )),
        ),
      ]),
    );
  }

  Widget _generateItem(int index, Privileges menuItem, double level) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                menuItem.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              ListTile(
                leading: Icon(getIconForName(menuItem.icon)),
                title: Text(menuItem.name),
              ),
              SizedBox(
                height: 65 * (menuItem.children.length.toDouble() / 2),
                child: GridView.count(
                    physics: const ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    children: menuItem.children.map((Privileges item) {
                      return GestureDetector(
                        onTap: () {
                          if (item.id == 'user') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserScreen(
                                        authInfo: authInfo,
                                      )),
                            );
                          }
                        },
                        child: ListTile(
                          leading: Icon(getIconForName(item.icon)),
                          title: Text(item.name),
                        ),
                      );
                    }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _generateChildren(int count, List<Privileges> menusList) {
    List<Widget> items = [];
    if (count == 0) {
      items.add(Center(child: Text("Errors")));
      return items;
    } else {
      for (int i = 0; i < count; i++) {
        items.add(_generateItem(i, menusList[i], 0));
      }
      return items;
    }
  }

  IconData getIconForName(String iconName) {
    switch (iconName) {
      case 'assignments':
        {
          return Icons.assignment;
        }
      case 'contacts':
        {
          return Icons.contacts;
        }
      case 'person':
        {
          return Icons.person;
        }
      case 'credit_card':
        {
          return Icons.credit_card;
        }
      case 'settings':
        {
          return Icons.settings;
        }
      case 'group':
        {
          return Icons.group;
        }
      case 'pie_chart':
        {
          return Icons.pie_chart;
        }
      case 'zoom_in':
        {
          return Icons.zoom_in;
        }
      case 'chrome_reader_mode':
        {
          return Icons.chrome_reader_mode;
        }
      case 'attach_money':
        {
          return Icons.attach_money;
        }
      default:
        {
          return Icons.settings;
        }
    }
  }
}
