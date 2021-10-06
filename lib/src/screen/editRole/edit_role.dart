import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/screen/editRole/edit_role_form.dart';
import 'package:flutter_admin/src/screen/editRole/role_search_form.dart';
import 'package:flutter_admin/src/services/role.dart';

class EditRoleScreen extends StatefulWidget {
  const EditRoleScreen({
    Key? key,
    required this.roleId,
  }) : super(key: key);
  final String roleId;

  @override
  _EditRoleScreenState createState() => _EditRoleScreenState();
}

class _EditRoleScreenState extends State<EditRoleScreen> {
  late List<Privilege> privileges = [];
  late Role role;
  late List<String> privilegeListByRole;
  bool loading = true;

  getPrivileges() async {
    final res = await RoleService.instance.getPrivileges();
    setState(() {
      privileges = res;
      loading = false;
    });
  }

  getRoleById() async {
    final res = await RoleService.instance.getRoleById(roleId: widget.roleId);
    setState(() {
      role = res;
      privilegeListByRole = res.privileges;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getRoleById();
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
                  bool findPrivilege =
                      privilegeListByRole.contains(privileges[index].id);
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
                              value: findPrivilege,
                              onChanged: (value) {
                                value == true
                                    ? setState(() {
                                        privilegeListByRole
                                            .add(privileges[index].id);
                                      })
                                    : setState(() {
                                        privilegeListByRole
                                            .remove(privileges[index].id);
                                      });
                              },
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
                              bool findPrivilege2 =
                                  privilegeListByRole.contains(
                                privileges[index].children[indexChildren].id,
                              );
                              return Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.lightGreen,
                                    value: findPrivilege2,
                                    onChanged: (value) {
                                      if (value == true) {
                                        setState(() {
                                          privilegeListByRole.add(
                                              privileges[index]
                                                  .children[indexChildren]
                                                  .id);
                                        });
                                      } else {
                                        setState(() {
                                          privilegeListByRole.remove(
                                              privileges[index]
                                                  .children[indexChildren]
                                                  .id);
                                        });
                                      }
                                    },
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
