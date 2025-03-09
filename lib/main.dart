import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_developer_intern/bloc/app_bloc.dart';
import 'package:mobile_developer_intern/data/data_provider/user_data_provider.dart';
import 'package:mobile_developer_intern/data/repository/user_repository.dart';
import 'package:mobile_developer_intern/first_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              AppBloc(UserRepository(userDataProvider: UserDataProvider())),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins', useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: FirstScreen(),
      ),
    );
  }
}
