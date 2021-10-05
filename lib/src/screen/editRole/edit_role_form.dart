import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/role.dart';

class EditRoleForm extends StatefulWidget {
  const EditRoleForm({Key? key, required this.role}) : super(key: key);
  final Role role;
  @override
  _EditRoleFormState createState() => _EditRoleFormState();
}

class _EditRoleFormState extends State<EditRoleForm> {
  TextEditingController _roleNameController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  late String status = widget.role.status;

  @override
  void initState() {
    super.initState();
    _roleNameController.text = widget.role.roleName.toString();
    _remarkController.text = widget.role.remark.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Role id',
                hintText: widget.role.roleId.toString(),
                labelStyle: TextStyle(color: Colors.black, fontSize: 22),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            TextField(
              controller: _roleNameController,
              enableSuggestions: false,
              autocorrect: false,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: 'Role Name',
                hintText: 'Role Name',
                labelStyle: TextStyle(color: Colors.black, fontSize: 22),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
            ),
            TextField(
              controller: _remarkController,
              enableSuggestions: false,
              autocorrect: false,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                labelText: 'Remark',
                hintText: 'Remark',
                labelStyle: TextStyle(color: Colors.black, fontSize: 22),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Status',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.lightGreen,
                  activeColor: Colors.lightGreen,
                  shape: CircleBorder(),
                  value: status == 'A' ? true : false,
                  onChanged: (value) {
                    if (value == true) {
                      setState(() {
                        status = 'A';
                      });
                    }
                  },
                ),
                Text('Active', style: TextStyle(fontSize: 16)),
                Checkbox(
                    checkColor: Colors.lightGreen,
                    activeColor: Colors.lightGreen,
                    shape: CircleBorder(),
                    value: status == 'I' ? true : false,
                    onChanged: (value) {
                      if (value == true) {
                        setState(() {
                          status = 'I';
                        });
                      }
                    }),
                Text(
                  'Inactive',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
