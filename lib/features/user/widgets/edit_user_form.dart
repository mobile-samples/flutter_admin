import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/utils/general_method.dart';

import '../../role/role_model.dart';
import '../user_model.dart';

class EditUserFormScreen extends StatefulWidget {
  const EditUserFormScreen({
    super.key,
    required this.userDetail,
    required this.handleClickSave,
  });
  final User userDetail;
  final Function handleClickSave;

  @override
  State<EditUserFormScreen> createState() => _EditUserFormScreenState();
}

class _EditUserFormScreenState extends State<EditUserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> itemsTitle = ['Mr', 'Mrs', 'Ms', 'Dr'];
  List<String> itemsPosition = ['Employee', 'Manager', 'Director'];

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();

  late String title = widget.userDetail.title!;
  late String position = widget.userDetail.position!;
  late String gender = widget.userDetail.gender!;
  late String status =
      widget.userDetail.status == 'A' ? Status.active : Status.inactive;

  late String? selectedTitle =
      title.isNotEmpty ? itemsTitle[itemsTitle.indexOf(title)] : null;

  late String? selectedPosition = position.isNotEmpty
      ? itemsPosition.firstWhere((e) => e.startsWith(position))
      : null;

  @override
  void initState() {
    super.initState();
    _displayNameController.text = widget.userDetail.displayName;
    _phoneNumberController.text = widget.userDetail.phone!;
    _emailAddressController.text = widget.userDetail.email;
  }

  void handlePressSave() async {
    late User postForm = User(
      widget.userDetail.userId,
      widget.userDetail.username,
      _emailAddressController.text,
      _displayNameController.text,
      widget.userDetail.imageURL,
      status,
      gender,
      _phoneNumberController.text,
      title,
      position,
      widget.userDetail.roles,
    );
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      await widget.handleClickSave(postForm);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Successfully updated')));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in the fields above')),
      );
    }
  }

  void handleChangeTitle(String? value) {
    switch (value) {
      case 'Mr':
        setState(() {
          gender = 'M';
          title = value!;
        });
        break;
      default:
        setState(() {
          gender = 'F';
          value != null ? title = value : title = '';
        });
        break;
    }
  }

  void handleChangePosition(String? value) {
    // ['Employee', 'Manager', 'Director']
    switch (value) {
      case 'Employee':
        setState(() {
          position = 'E';
        });
        break;
      case 'Manager':
        setState(() {
          position = 'M';
        });
        break;
      case 'Director':
        setState(() {
          position = 'D';
        });
        break;
      default:
        setState(() {
          position = '';
        });
        break;
    }
  }

  void handleChangeGender(bool? value, String text) {
    if (title == 'Dr' && value == true) {
      setState(() {
        gender = text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final validateForm = ValidateForm(context: context);
    return SliverToBoxAdapter(
        child: Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
      child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'User Id*',
                labelStyle:
                    const TextStyle(color: Colors.black54, fontSize: 22),
                hintText: widget.userDetail.userId,
                hintStyle: const TextStyle(height: 2.0),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              enabled: false,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Display Name*',
                labelStyle: TextStyle(color: Colors.black54, fontSize: 22),
                hintText: 'Display Name',
                hintStyle: TextStyle(height: 2.0),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              controller: _displayNameController,
              enableSuggestions: false,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateForm.validator,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            DropdownSearch<String>(
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.black54, fontSize: 22),
                  hintText: 'Please Select',
                  contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              // mode: Mode.MENU,
              items: itemsTitle,
              selectedItem: selectedTitle,
              onChanged: handleChangeTitle,
              validator: validateForm.validator,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              clearButtonProps: const ClearButtonProps(isVisible: true),
              // showSelectedItems: true,
            ),
            DropdownSearch<String>(
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Position',
                  hintText: 'Please Select',
                  labelStyle: TextStyle(color: Colors.black54, fontSize: 22),
                  contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              // mode: Mode.MENU,
              items: itemsPosition,
              selectedItem: selectedPosition,
              onChanged: handleChangePosition,
              validator: validateForm.validator,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              clearButtonProps: const ClearButtonProps(isVisible: true),
              // showSelectedItems: true,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Telephone',
                labelStyle: TextStyle(color: Colors.black54, fontSize: 22),
                hintText: 'Telephone',
                hintStyle: TextStyle(height: 2.0),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              controller: _phoneNumberController,
              enableSuggestions: false,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateForm.validatorForPhoneNumber,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black54, fontSize: 22),
                hintText: 'Email',
                hintStyle: TextStyle(height: 2.0),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              controller: _emailAddressController,
              enableSuggestions: false,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateForm.validatorForEmail,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: RadioListTile<String>(
                          title: const Text('Yes'),
                          activeColor: Colors.lightGreen,
                          value: Status.active,
                          groupValue: status,
                          onChanged: (value) {
                            setState(() {
                              status = value!;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: RadioListTile<String>(
                          title: const Text('No'),
                          activeColor: Colors.lightGreen,
                          value: Status.inactive,
                          groupValue: status,
                          onChanged: (value) {
                            setState(() {
                              status = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.lightGreen,
                        activeColor: Colors.lightGreen,
                        shape: const CircleBorder(),
                        value: gender == 'F' ? true : false,
                        onChanged: (bool? value) {
                          handleChangeGender(value, 'F');
                        },
                      ),
                      const Text('Female', style: TextStyle(fontSize: 16)),
                      Checkbox(
                          checkColor: Colors.lightGreen,
                          activeColor: Colors.lightGreen,
                          shape: const CircleBorder(),
                          value: gender == 'M' ? true : false,
                          onChanged: (bool? value) {
                            handleChangeGender(value, 'M');
                          }),
                      const Text(
                        'Male',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: handlePressSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            )
          ])),
    ));
  }
}
