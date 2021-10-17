import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/models/user.dart';

class EditUserFormScreen extends StatefulWidget {
  const EditUserFormScreen({
    Key? key,
    required this.userDetail,
    required this.handleClickSave,
  }) : super(key: key);
  final User userDetail;
  final Function handleClickSave;

  @override
  _EditUserFormScreenState createState() => _EditUserFormScreenState();
}

class _EditUserFormScreenState extends State<EditUserFormScreen> {
  final _formKey = new GlobalKey<FormState>();
  List<String> itemsTitle = ['Mr', 'Mrs', 'Ms', 'Dr'];
  List<String> itemsPosition = ['Employee', 'Manager', 'Director'];

  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();

  late String title = widget.userDetail.title;
  late String position = widget.userDetail.position;
  late String gender = widget.userDetail.gender;
  late String status =
      widget.userDetail.status == 'A' ? Status.active : Status.inactive;
  // late String status = widget.userDetail.status;

  late String? selectedTitle =
      title.isNotEmpty ? itemsTitle[itemsTitle.indexOf(title)] : null;

  late String? selectedPosition = position.isNotEmpty
      ? itemsPosition.firstWhere((e) => e.startsWith(position))
      : null;

  @override
  void initState() {
    super.initState();
    _displayNameController.text = widget.userDetail.displayName;
    _phoneNumberController.text = widget.userDetail.phone;
    _emailAddressController.text = widget.userDetail.email;
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

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This Field Can\'t Be Empty';
    } else {
      return null;
    }
  }

  String? validatorForEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'This Field Can\'t Be Empty';
    }
    bool checkValidEmail = !EmailValidator.validate(value);
    if (checkValidEmail) {
      return 'Not a valid email.';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'User Id*',
                    labelStyle: TextStyle(color: Colors.black54, fontSize: 22),
                    hintText: widget.userDetail.userId,
                    hintStyle: TextStyle(height: 2.0),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  enabled: false,
                ),
                TextFormField(
                  decoration: InputDecoration(
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
                  validator: validator,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                DropdownSearch<String>(
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
                  mode: Mode.MENU,
                  items: itemsTitle,
                  selectedItem: selectedTitle,
                  onChanged: handleChangeTitle,
                  validator: validator,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  showClearButton: true,
                  showSelectedItems: true,
                ),
                DropdownSearch<String>(
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
                  mode: Mode.MENU,
                  items: itemsPosition,
                  selectedItem: selectedPosition,
                  onChanged: handleChangePosition,
                  validator: validator,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  showClearButton: true,
                  showSelectedItems: true,
                ),
                TextFormField(
                  decoration: InputDecoration(
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
                  validator: validatePhoneNumber,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
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
                  validator: validatorForEmail,
                  style: TextStyle(
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
                      Text(
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
                      Text(
                        'Gender',
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.lightGreen,
                            activeColor: Colors.lightGreen,
                            shape: CircleBorder(),
                            value: gender == 'F' ? true : false,
                            onChanged: (bool? value) {
                              handleChangeGender(value, 'F');
                            },
                          ),
                          Text('Female', style: TextStyle(fontSize: 16)),
                          Checkbox(
                              checkColor: Colors.lightGreen,
                              activeColor: Colors.lightGreen,
                              shape: CircleBorder(),
                              value: gender == 'M' ? true : false,
                              onChanged: (bool? value) {
                                handleChangeGender(value, 'M');
                              }),
                          Text(
                            'Male',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(60, 10, 60, 10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
