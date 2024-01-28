import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_admin/features/auth/auth_model.dart';
import 'package:flutter_admin/features/user/widgets/user_list.dart';
import 'package:flutter_admin/features/role/widgets/role_list.dart';
import 'package:flutter_admin/utils/auth_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Privileges> privileges = [];

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
    AuthStorage.getInfo('user').then((value) {
      AuthInfo authInfo = AuthInfo.fromJson(jsonDecode(value));
      setState(() {
        privileges = authInfo.privileges;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: privileges.length,
      itemBuilder: (BuildContext context, int index) =>
          _buildList(privileges[index]),
    );
  }

  Widget _buildList(Privileges item) {
    if (item.children.isEmpty) {
      return Builder(builder: (context) {
        return Material(
          child: ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => item.id == 'user'
                        ? const UserScreen()
                        : const RoleScreen())),
            leading: const SizedBox(),
            title: Text(
              item.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        );
      });
    }
    return Material(
        child: ExpansionTile(
      leading: Icon(getIconForName(item.icon)),
      title: Text(
        item.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      children: item.children.map(_buildChildren).toList(),
    ));
  }

  Widget _buildChildren(Privileges item) {
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
        ),
      );
    });
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
