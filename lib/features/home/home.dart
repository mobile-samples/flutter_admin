import 'package:flutter/material.dart';
import 'package:flutter_admin/features/home/home_provider.dart';
import 'package:flutter_admin/features/login/auth_model.dart';
import 'package:flutter_admin/features/user/user.dart';
import 'package:flutter_admin/features/role/role.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthInfo authInfo;
  List<Privileges> data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  getData() async {
    authInfo = AuthInheritedWidget.of(context)!.authData;
    setState(() {
      data = authInfo.privileges;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => _buildList(data[index]),
    );
  }

  Widget _buildList(Privileges item) {
    if (item.children.isEmpty) {
      return Builder(builder: (context) {
        return ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => item.id == 'user'
                        ? const UserScreen()
                        : const RoleScreen())),
            leading: const SizedBox(),
            title: Text(
              item.name,
              style: Theme.of(context).textTheme.titleSmall,
            ));
      });
    }
    return ExpansionTile(
      leading: Icon(getIconForName(item.icon)),
      title: Text(
        item.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      children: item.children.map(_buildList).toList(),
    );
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
