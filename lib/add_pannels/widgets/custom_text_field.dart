import 'package:flutter/material.dart';

import '../../onboarding/util/utils.dart';


class custom_text_field extends StatelessWidget {
  TextEditingController txt_cont;
  String label;
  custom_text_field({super.key , required this.txt_cont , required this.label});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(right: 20),
      child: TextField(
        style: TextStyle(
            color: black
        ),
        cursorColor: black,
        controller: txt_cont,
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}