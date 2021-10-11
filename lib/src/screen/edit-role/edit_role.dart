import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/screen/edit-role/edit_role_form.dart';
import 'package:flutter_admin/src/screen/edit-role/role_search_form.dart';
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
  late List<String> privilegeListByRole = [];
  late Role role;

  late List<Privilege> privileges = [];
  late List<String> formatPrivileges = [];

  late List<Privilege> searchPrivi = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getRoleById();
    getPrivileges();
  }

  getPrivileges() async {
    final res = await RoleService.instance.getPrivileges();
    formatPrivilege(res);
    setState(() {
      privileges = res;
      searchPrivi = res;
      loading = false;
    });
  }

  getRoleById() async {
    final res = await RoleService.instance.load(widget.roleId);
    setState(() {
      role = res;
      privilegeListByRole = res.privileges;
      loading = false;
    });
  }

  formatPrivilege(List<Privilege> privi) {
    List<String> newList = [];
    privi.forEach((e) {
      newList.add(e.id);
      if (e.children.isNotEmpty) {
        newList.addAll(e.children.map((e) => e.id));
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

  handleCheckedByParent(bool value, int index) {
    final List<String> clone = [...privilegeListByRole];
    if (value == true) {
      clone.add(searchPrivi[index].id);
      clone.addAll(searchPrivi[index].children.map((e) => e.id));
    } else {
      clone.remove(searchPrivi[index].id);
      searchPrivi[index].children.forEach((e) {
        clone.remove(e.id);
      });
    }
    setState(() {
      privilegeListByRole = clone;
    });
  }

  handleCheckedByChild(bool value, int index, int indexChild) {
    final List<String> clone = [...privilegeListByRole];
    int count = 0;

    if (value == false) {
      clone.remove(searchPrivi[index].children[indexChild].id);
    } else if (value == true) {
      clone.add(searchPrivi[index].children[indexChild].id);
    }

    searchPrivi[index].children.forEach((e) {
      if (clone.contains(e.id) == true) {
        count++;
      }
    });

    if (count > 0 && clone.contains(searchPrivi[index].id) == false) {
      clone.add(searchPrivi[index].id);
    } else if (count == 0 && clone.contains(searchPrivi[index].id) == true) {
      clone.remove(searchPrivi[index].id);
    }

    setState(() {
      privilegeListByRole = clone;
    });
  }

  handleSearch(String value) {
    List<Privilege> deepClone = [];

    if (value == '') {
      setState(() {
        searchPrivi = privileges;
      });
    }
    privileges.forEach((e) {
      final checkParent = e.name
          .replaceAll(' ', '')
          .toLowerCase()
          .indexOf(value.replaceAll(' ', '').toLowerCase());
      final newChilds = e.children
          .where((e1) =>
              e1.name
                  .replaceAll(' ', '')
                  .toLowerCase()
                  .indexOf(value.replaceAll(' ', '').toLowerCase()) !=
              -1)
          .toList();
      if (checkParent != -1 || newChilds.length > 0) {
        final Privilege newPrivi = new Privilege(e.id, e.name, newChilds);
        deepClone.add(newPrivi);
      }
    });

    setState(() {
      searchPrivi = deepClone;
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
              handleSearch: handleSearch,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                // final List<Privilege> list =
                //     // privilegeFilter.length > 0 ? privilegeFilter : privileges;
                //     privilegeFilter.isNotEmpty ? privilegeFilter : privileges;
                bool findPrivilege =
                    privilegeListByRole.contains(searchPrivi[index].id);
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
                            searchPrivi[index].name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 35),
                        child: Column(
                          children:
                              List.generate(searchPrivi[index].children.length,
                                  (indexChildren) {
                            bool findPrivilege2 = privilegeListByRole.contains(
                              searchPrivi[index].children[indexChildren].id,
                            );
                            return Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.lightGreen,
                                  value: findPrivilege2,
                                  onChanged: (value) {
                                    handleCheckedByChild(
                                        value!, index, indexChildren);
                                  },
                                ),
                                Text(
                                  searchPrivi[index]
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
              childCount: searchPrivi.length > 0 ? searchPrivi.length : 0,
            ))
          ],
        ),
      );
    }
  }
}
