import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/role.dart';

class RoleForm extends StatefulWidget {
  const RoleForm({
    Key? key,
    required this.initialRole,
    required this.handleSearchFilter,
  }) : super(key: key);

  final RoleFilter initialRole;
  final Function handleSearchFilter;

  @override
  _RoleFormState createState() => _RoleFormState();
}

class _RoleFormState extends State<RoleForm> {
  TextEditingController roleNameController = TextEditingController();
  bool checkActive = false;
  bool checkInactive = false;
  List<String> newStatus = [];

  handleSearchClick(int? newLimit) {
    final RoleFilter formFilter = RoleFilter(
      roleNameController.value.text,
      newStatus,
      newLimit!,
      1,
    );
    widget.handleSearchFilter(formFilter);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Role name:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    controller: roleNameController,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Status:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.lightGreen,
                          value: checkActive,
                          onChanged: (value) {
                            setState(() {
                              checkActive = value!;
                              checkActive == true
                                  ? newStatus.add("A")
                                  : newStatus.remove("A");
                            });
                          },
                        ),
                        Text('Active')
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.lightGreen,
                          value: checkInactive,
                          onChanged: (value) {
                            setState(() {
                              checkInactive = value!;
                              checkInactive == true
                                  ? newStatus.add("I")
                                  : newStatus.remove("I");
                            });
                          },
                        ),
                        Text('Inactive')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Row(
                    children: [
                      Text('Page Size: ', style: TextStyle(fontSize: 16.0)),
                      DropdownButton<String>(
                        value: widget.initialRole.limit.toString(),
                        iconSize: 0.0,
                        onChanged: (String? newValue) {
                          handleSearchClick(int.parse(newValue!));
                        },
                        items: <String>['5', '10', '20', '40']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    handleSearchClick(widget.initialRole.limit);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
