import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextInputField extends StatelessWidget {
  final String initialValue;
  final String label;
  final String hintText;
  final Widget? prefix;
  final FormFieldSetter<String>? onsaved;
  final FormFieldValidator<String>? validator;

  const CustomTextInputField({
    Key? key,
    required this.initialValue,
    required this.label,
    required this.hintText,
    this.validator,
    this.prefix,
    this.onsaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      onSaved: onsaved,
      validator: validator,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        prefixIcon: prefix,
        hintText: hintText,
      ),
    );
  }
}
