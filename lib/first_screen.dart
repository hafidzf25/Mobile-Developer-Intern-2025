import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_developer_intern/bloc/app_bloc.dart';
import 'package:mobile_developer_intern/widgets/blue_button.dart';
import 'package:mobile_developer_intern/widgets/input_text.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final palindromeController = TextEditingController();
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppInitial) {
          nameController.text = state.name;
          palindromeController.text = state.palindrome;
          if (state.checkPalindrome == true) {
            if (state.isPolindrome == false) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('not palindrome')));
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('isPalindrome')));
            }
          } else if (state.checkNext == true) {
            state.checkNext = false;
          }
          state.checkPalindrome = false;
        }
      },
      builder: (context, state) {
        if (state is AppInitial) {
          nameController.text = state.name;
          palindromeController.text = state.palindrome;
          
        }
        return Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/ic_photo.png', width: 116),
                  SizedBox(height: 58),
                  InputText(hint: 'Name', input: 1),
                  SizedBox(height: 22),
                  InputText(hint: 'Palindrome', input: 2),
                  SizedBox(height: 45),
                  BlueButton(
                    label: 'CHECK',
                    input: palindromeController.text.trim(),
                    input2: nameController.text.trim(),
                    button: 1,
                  ),
                  SizedBox(height: 15),
                  BlueButton(
                    label: 'NEXT',
                    input: nameController.text.trim(),
                    input2: nameController.text.trim(),
                    button: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
