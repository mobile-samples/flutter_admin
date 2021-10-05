import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/screen/editRole/edit_role_form.dart';
import 'package:flutter_admin/src/screen/editRole/role_search_form.dart';
import 'package:flutter_admin/src/services/auth.dart';

class EditRoleScreen extends StatefulWidget {
  const EditRoleScreen({
    Key? key,
    required this.token,
    required this.roleId,
  }) : super(key: key);
  final String token;
  final String roleId;

  @override
  _EditRoleScreenState createState() => _EditRoleScreenState();
}

class _EditRoleScreenState extends State<EditRoleScreen> {
  late List<Privilege> privileges = [];
  late Role role;
  bool loading = true;

  getPrivileges() async {
    final res = await APIService.instance.getPrivileges(token: widget.token);
    setState(() {
      privileges = res;
      loading = false;
    });
  }

  getSpecificRole() async {
    final res = await APIService.instance
        .getSpecificRole(token: widget.token, roleId: widget.roleId);
    setState(() {
      role = res;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSpecificRole();
    getPrivileges();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Center(
        child: Text('loading...'),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.green[400],
              title: Text('Edit role'),
            ),
            EditRoleForm(
              role: role,
            ),
            RoleSearchForm(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black38)),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.lightGreen,
                              value: role.privileges
                                  .contains(privileges[index].id),
                              onChanged: (value) {},
                            ),
                            Text(
                              privileges[index].name,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 35),
                          child: Column(
                            children:
                                List.generate(privileges[index].children.length,
                                    (indexChildren) {
                              return Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.lightGreen,
                                    value: role.privileges.contains(
                                        privileges[index]
                                            .children[indexChildren]
                                            .id),
                                    onChanged: (value) {},
                                  ),
                                  Text(
                                    privileges[index]
                                        .children[indexChildren]
                                        .name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  );
                },
                childCount: privileges.length > 0 ? privileges.length : 0,
              ),
            )
          ],
        ),
      );
    }
  }
}
