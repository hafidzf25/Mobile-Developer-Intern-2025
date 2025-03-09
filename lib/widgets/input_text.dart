import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_developer_intern/bloc/app_bloc.dart';

class InputText extends StatelessWidget {
  final int input;
  final String hint;
  const InputText({super.key, required this.hint, required this.input});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 16, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xffE2E3E4), width: 0.5),
      ),
      child: TextField(
        onChanged: (value) {
          if (input == 1) {
            context.read<AppBloc>().add(OnInputName(inputName: value));
          } else if (input == 2) {
            context.read<AppBloc>().add(
              OnInputPalindrome(inputPalindrome: value),
            );
          }
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Color.fromRGBO(68, 67, 77, 0.36),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
