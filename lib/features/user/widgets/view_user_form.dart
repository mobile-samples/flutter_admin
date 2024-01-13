import 'package:flutter/material.dart';

import '../../role/role_model.dart';
import '../user_model.dart';
import 'edit_user.dart';

class ViewUserFormScreen extends StatefulWidget {
  const ViewUserFormScreen({
    super.key,
    required this.userDetail,
    required this.handleChangeUser,
  });
  final User userDetail;
  final Function handleChangeUser;

  @override
  State<ViewUserFormScreen> createState() => _ViewUserFormScreenState();
}

class _ViewUserFormScreenState extends State<ViewUserFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late String title = widget.userDetail.title!;
  late String position = widget.userDetail.position!;
  late String gender = widget.userDetail.gender!;
  late String status =
      widget.userDetail.status == 'A' ? Status.active : Status.inactive;

  String? getStatus(String status) =>
      status == Status.active ? "Active" : "Inactive";

  @override
  void initState() {
    super.initState();
  }

  List<String> itemsPosition = ['Employee', 'Manager', 'Director'];

  String? getPosition(String position) =>
      itemsPosition.firstWhere((e) => e.startsWith(position));

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 300),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditUserScreen(
                              user: widget.userDetail,
                              handleChangeUser: widget.handleChangeUser)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'User Id',
                    labelStyle:
                        const TextStyle(color: Colors.black54, fontSize: 22),
                    hintText: widget.userDetail.userId,
                    hintStyle:
                        const TextStyle(height: 2.0, color: Colors.black),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  enabled: false,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle:
                        const TextStyle(color: Colors.black54, fontSize: 22),
                    hintText:
                        "${widget.userDetail.title!} ${widget.userDetail.displayName}",
                    hintStyle:
                        const TextStyle(height: 2.0, color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  enabled: false,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Position',
                    labelStyle:
                        const TextStyle(color: Colors.black54, fontSize: 22),
                    hintText: getPosition(widget.userDetail.position!),
                    hintStyle:
                        const TextStyle(height: 2.0, color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  enabled: false,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Telephone',
                    labelStyle:
                        const TextStyle(color: Colors.black54, fontSize: 22),
                    hintText: widget.userDetail.phone,
                    hintStyle:
                        const TextStyle(height: 2.0, color: Colors.black),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  enabled: false,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                        const TextStyle(color: Colors.black54, fontSize: 22),
                    hintText: widget.userDetail.email,
                    hintStyle:
                        const TextStyle(height: 2.0, color: Colors.black),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  enabled: false,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Status',
                    labelStyle:
                        const TextStyle(color: Colors.black54, fontSize: 22),
                    hintText: getStatus(widget.userDetail.status),
                    hintStyle: TextStyle(
                        height: 2.0,
                        color: widget.userDetail.status == Status.active
                            ? Colors.lightGreen
                            : Colors.redAccent),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  enabled: false,
                ),
              ],
            ),
          )),
    );
  }
}
