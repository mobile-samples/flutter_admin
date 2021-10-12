import 'package:flutter/material.dart';

class EditRoleForm extends StatefulWidget {
  const EditRoleForm({
    Key? key,
    required this.roleId,
    required this.roleNameController,
    required this.remarkController,
    required this.status,
    required this.handleStatus,
  }) : super(key: key);

  final String roleId;
  final TextEditingController roleNameController;
  final TextEditingController remarkController;
  final String status;
  final Function handleStatus;
  @override
  _EditRoleFormState createState() => _EditRoleFormState();
}

class _EditRoleFormState extends State<EditRoleForm> {
  @override
  void initState() {
    super.initState();
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
                labelText: '*Role Id',
                hintText: widget.roleId,
                labelStyle: TextStyle(color: Colors.black, fontSize: 22),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            TextField(
              controller: widget.roleNameController,
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
              controller: widget.remarkController,
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
                  value: widget.status == 'A' ? true : false,
                  onChanged: (value) {
                    if (value == true) {
                      widget.handleStatus('A');
                    }
                  },
                ),
                Text('Active', style: TextStyle(fontSize: 16)),
                Checkbox(
                    checkColor: Colors.lightGreen,
                    activeColor: Colors.lightGreen,
                    shape: CircleBorder(),
                    value: widget.status == 'I' ? true : false,
                    onChanged: (value) {
                      if (value == true) {
                        widget.handleStatus('I');
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
