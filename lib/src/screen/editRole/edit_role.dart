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
  TextEditingController searchController = TextEditingController();

  late List<Privilege> privileges = [];
  late List<String> formatPrivileges = [];
  late List<String> adminChildList = [];
  late List<String> setupChildList = [];
  late List<String> reportChildList = [];

  late List<String> privilegeListByRole = [];

  late Role role;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getRoleById();
    getPrivileges();
  }

  // getPriviChildList(List<Privilege> privi) {
  //   final List<String> adminChildList1 = [];
  //   final List<String> setupChildList2 = [];
  //   final List<String> reportChildList3 = [];
  //   privi.forEach((e) {
  //     if (e.children.length > 0) {
  //       switch (e.id) {
  //         case 'admin':
  //           adminChildList1.addAll(e.children.map((e) => e.id));
  //           break;
  //         case 'setup':
  //           setupChildList2.addAll(e.children.map((e) => e.id));
  //           break;
  //         case 'report':
  //           reportChildList3.addAll(e.children.map((e) => e.id));
  //           break;
  //         default:
  //           break;
  //       }
  //     }
  //   });
  //   setState(() {
  //     adminChildList = adminChildList1;
  //     setupChildList = setupChildList2;
  //     reportChildList = reportChildList3;
  //   });
  // }

  handleCheckedByChild(bool value, int index, int indexChild) {
    List<String> clone = [...privilegeListByRole];
    int count = 0;

    if (value == false) {
      clone.remove(privileges[index].children[indexChild].id);
    } else if (value == true) {
      clone.add(privileges[index].children[indexChild].id);
    }

    privileges[index].children.forEach((e) {
      if (clone.contains(e.id) == true) {
        count++;
      }
    });

    if (count > 0 && clone.contains(privileges[index].id) == false) {
      clone.add(privileges[index].id);
    } else if (count == 0 && clone.contains(privileges[index].id) == true) {
      clone.remove(privileges[index].id);
    }

    setState(() {
      privilegeListByRole = clone;
    });
  }

  handleCheckedByParent(bool value, int index) {
    List<String> clonePrivByRole = [...privilegeListByRole];
    if (value == true) {
      clonePrivByRole.add(privileges[index].id);
      clonePrivByRole.addAll(privileges[index].children.map((e) => e.id));
    } else {
      clonePrivByRole.remove(privileges[index].id);
      privileges[index].children.forEach((e) {
        clonePrivByRole.remove(e.id);
      });
    }
    setState(() {
      privilegeListByRole = clonePrivByRole;
    });
  }

  formatPrivilege(List<Privilege> privi) {
    List<String> newList = [];
    privi.forEach((e) {
      newList.add(e.id);
      if (e.children.isNotEmpty) {
        e.children.forEach((e1) {
          newList.add(e1.id);
        });
      }
    });
    setState(() {
      formatPrivileges = newList;
    });
  }

  handleCheckAll(bool check, List<String> list) {
    if (check == false) {
      setState(() {
        privilegeListByRole = list;
      });
    }
    setState(() {
      privilegeListByRole.addAll(list);
    });
  }

  getPrivileges() async {
    final res = await RoleService.instance.getPrivileges();
    formatPrivilege(res);
    // getPriviChildList(res);
    setState(() {
      privileges = res;
      loading = false;
    });
  }

  getRoleById() async {
    final res = await RoleService.instance.getRoleById(widget.roleId);
    setState(() {
      role = res;
      privilegeListByRole = res.privileges;
      loading = false;
    });
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
            RoleSearchForm(
              privilegesByRole: privilegeListByRole,
              allPrivilege: formatPrivileges,
              handleCheckAll: handleCheckAll,
              searchController: searchController,
            ),
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
                                handleCheckedByParent(value!, index);
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
                                      // if (value == true) {
                                      //   setState(() {
                                      //     privilegeListByRole.add(
                                      //         privileges[index]
                                      //             .children[indexChildren]
                                      //             .id);
                                      //   });
                                      // } else {
                                      //   setState(() {
                                      //     privilegeListByRole.remove(
                                      //         privileges[index]
                                      //             .children[indexChildren]
                                      //             .id);
                                      //   });
                                      // }
                                      handleCheckedByChild(
                                          value!, index, indexChildren);
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
