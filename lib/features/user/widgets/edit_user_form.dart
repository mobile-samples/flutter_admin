import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/common/widget/size.dart';
import 'package:flutter_admin/utils/general_method.dart';

import '../../role/role_model.dart';
import '../user_service.dart';
import '../user_model.dart';

class EditUserFormScreen extends StatefulWidget {
  const EditUserFormScreen({
    super.key,
    required this.user,
    required this.handleChangeUser,
  });
  final User user;
  final Function handleChangeUser;

  @override
  State<EditUserFormScreen> createState() => _EditUserFormScreenState();
}

class _EditUserFormScreenState extends State<EditUserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late User userDetail;
  late bool _loading;

  List<String> itemsTitle = ['Mr', 'Mrs', 'Ms', 'Dr'];
  List<String> itemsPosition = ['Employee', 'Manager', 'Director'];

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();

  late String title = userDetail.title!;
  late String position = userDetail.position!;
  late String gender = userDetail.gender!;
  late String status = userDetail.status == 'A' ? Status.active : Status.inactive;

  late String? selectedTitle =
      title.isNotEmpty ? itemsTitle[itemsTitle.indexOf(title)] : null;

  late String? selectedPosition = position.isNotEmpty
      ? itemsPosition.firstWhere((e) => e.startsWith(position))
      : null;

  @override
  void initState() {
    super.initState();
    setState(() {
      userDetail = widget.user;
      _loading = false;
    });
    _displayNameController.text = userDetail.displayName;
    _phoneNumberController.text = userDetail.phone!;
    _emailAddressController.text = userDetail.email;
  }

  void handlePressSave() async {
    late User postForm = User(
      userDetail.userId,
      userDetail.username,
      _emailAddressController.text,
      _displayNameController.text,
      userDetail.imageURL,
      status,
      gender,
      _phoneNumberController.text,
      title,
      position,
      userDetail.roles,
    );
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      if (!_loading) {
        _loading = true;
        await UserAPIService.instance.update(postForm);
        setState(() {
          userDetail = postForm;
          _loading = false;
        });
        widget.handleChangeUser(postForm);
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Successfully updated')));
        Navigator.pop(context, true);
      }
      
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
    if (_loading == true) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green[400],
            title: const Text('Edit user'),
          ),
          SliverToBoxAdapter(
            child: Container(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'User Id*',
                      hintText: userDetail.userId,
                    ),
                    enabled: false,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Display Name*',
                      hintText: 'Display Name',
                    ),
                    controller: _displayNameController,
                    enableSuggestions: false,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateForm.validator,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  DropdownSearch<String>(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Please Select',
                      ),
                    ),
                    items: itemsTitle,
                    selectedItem: selectedTitle,
                    onChanged: handleChangeTitle,
                    validator: validateForm.validator,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    clearButtonProps: const ClearButtonProps(isVisible: true),
                  ),
                  DropdownSearch<String>(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Position',
                        hintText: 'Please Select',
                      ),
                    ),
                    items: itemsPosition,
                    selectedItem: selectedPosition,
                    onChanged: handleChangePosition,
                    validator: validateForm.validator,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    clearButtonProps: const ClearButtonProps(isVisible: true),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Telephone',
                      hintText: 'Telephone',
                    ),
                    controller: _phoneNumberController,
                    enableSuggestions: false,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateForm.validatorForPhoneNumber,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email',
                    ),
                    controller: _emailAddressController,
                    enableSuggestions: false,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateForm.validatorForEmail,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  AppSizedWidget.spaceHeight(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
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
                  AppSizedWidget.spaceHeight(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: RadioListTile<String>(
                              title: const Text('Female'),
                              activeColor: Colors.lightGreen,
                              value: "F",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: RadioListTile<String>(
                              title: const Text('Male'),
                              activeColor: Colors.lightGreen,
                              value: 'M',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppSizedWidget.spaceHeight(20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ),
                      AppSizedWidget.spaceWidth(10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: handlePressSave,
                          child: const Text('Save'),
                        ),
                      )
                    ],
                  ),
                ]
              )
            ),
          )
        ),
      ]),
    );
  }
}
