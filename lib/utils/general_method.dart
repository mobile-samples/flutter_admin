import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class GeneralMethod {
  static autoScrollOnTop(ScrollController controller) {
    controller.animateTo(
      controller.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }
}

class ValidateForm {
  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This Field Can\'t Be Empty';
    } else {
      return null;
    }
  }

  static String? validatorForEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'This Field Can\'t Be Empty';
    }
    bool checkValidEmail = !EmailValidator.validate(value);
    if (checkValidEmail) {
      return 'Not a valid email.';
    }
    return null;
  }

  static String? validatorForPhoneNumber(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid phone number';
    }
    return null;
  }
}
