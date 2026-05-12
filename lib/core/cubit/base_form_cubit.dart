import 'package:flutter/material.dart';
import 'async_cubit.dart';

abstract class BaseFormCubit<T> extends AsyncCubit<T> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool validateForm(void Function() onInvalid) {
    if (!formKey.currentState!.validate()) {
      autovalidateMode = AutovalidateMode.always;
      onInvalid();
      return false;
    }
    formKey.currentState!.save();
    return true;
  }
}
