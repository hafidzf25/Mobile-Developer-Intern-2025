import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_developer_intern/bloc/app_bloc.dart';
import 'package:mobile_developer_intern/first_screen.dart';
import 'package:mobile_developer_intern/third_screen.dart';
import 'package:mobile_developer_intern/widgets/blue_button.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String name = '';
    String selectedUser = '';
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppLoggedUser) {
          if (state.checkNext == true) {
            state.checkNext = false;
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => ThirdScreen()));
          }
        }
      },
      builder: (context, state) {
        if (state is AppLoggedUser) {
          name = state.name;
          selectedUser = state.selectedName;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Second Screen',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(2),
              child: Container(color: Color(0xffE2E3E4), height: 1),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                context.read<AppBloc>().add(OnReset());
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => FirstScreen()),
                );
              },
              icon: Image.asset('assets/images/back.png', width: 24),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome', style: TextStyle(color: Color(0xff04021D))),
                    Text(
                      name,
                      style: TextStyle(
                        color: Color(0xff04021D),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedUser.isEmpty
                          ? 'Selected User Name'
                          : selectedUser,
                      style: TextStyle(
                        color: Color(0xff04021D),
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                BlueButton(
                  label: 'Choose a User',
                  input: name,
                  input2: '',
                  button: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
