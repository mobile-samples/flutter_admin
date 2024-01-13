import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  BuildContext context;
  ValidateForm({required this.context});

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.notEmptyMessage;
    } else {
      return null;
    }
  }

  String? validatorForEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.notEmptyMessage;
    }
    bool checkValidEmail = !EmailValidator.validate(value);
    if (checkValidEmail) {
      return AppLocalizations.of(context)!.invalidEmailMessage;
    }
    return null;
  }

  String? validatorForPhoneNumber(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.notEmptyMessage;
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.invalidPhoneNumberMessage;
    }
    return null;
  }
}
