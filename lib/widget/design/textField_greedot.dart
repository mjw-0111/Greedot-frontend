import 'package:flutter/material.dart';

import '../../widget/design/settingColor.dart';

class TextField_greedot extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;

  const TextField_greedot({super.key, 
    required this.controller,
    required this.labelText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: labelText.toLowerCase().contains("비밀번호"),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: colorAppbar_greedot,
          ),
        ),
        filled: true,
        fillColor: colorFilling_greedot,
      ),
    );
  }
}
