import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_developer_intern/bloc/app_bloc.dart';
import 'package:mobile_developer_intern/second_screen.dart';

class BlueButton extends StatelessWidget {
  final int button;
  final String label;
  final String input;
  final String input2;
  const BlueButton({
    super.key,
    required this.label,
    required this.input,
    required this.input2,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 41),
        backgroundColor: Color(0xff2B637B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        if (button == 1) {
          context.read<AppBloc>().add(
            OnClickCheck(palindrome: input, name: input2),
          );
        } else if (button == 2) {
          context.read<AppBloc>().add(OnClickNext(name: input));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return SecondScreen();
              },
            ),
          );
        } else if (button == 3) {
          context.read<AppBloc>().add(OnClickNextThirdPage(name: input));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
