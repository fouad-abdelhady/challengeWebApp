import '../../../constatnts/colors.dart';
import '../../../constatnts/strings.dart';
import '../../../utils/config/responsive.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget with Responsive {
  TextEditingController textEditingController;
  String label;
  String? Function(String)? validate;
  void Function(String?)? onChange;
  TextInputType textInputType;
  bool isNullable;
  bool isObsecure;
  CommonTextField(this.textEditingController, this.label,
      {super.key,
      this.validate,
      this.onChange,
      this.textInputType = TextInputType.text,
      this.isNullable = false,
      this.isObsecure = false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure,
      controller: textEditingController,
      onChanged: (value) {
        if (onChange == null) return;
        onChange!(value);
      },
      validator: (value) {
        if (isNullable) return null;
        if (value == null || value == "") {
          return Strings().emptyTextField;
        }
        if (validate != null) {
          return validate!(value);
        }
        return null;
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        labelStyle: TextStyle(
            fontSize: textScalleFactor(context, 15),
            fontWeight: FontWeight.bold),
        errorStyle: const TextStyle(color: AppColors.errorMessagesColor),
        label: Center(child: Text(label)),
      ),
      maxLines: 1,
      style: const TextStyle(
        color: Colors.black87,
      ),
      keyboardType: textInputType,
    );
  }
}
