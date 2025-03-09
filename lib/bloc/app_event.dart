part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

final class OnClickCheck extends AppEvent {
  final String palindrome;
  final String name;

  OnClickCheck({required this.palindrome, required this.name});
}

final class OnReset extends AppEvent {}

final class OnRefresh extends AppEvent {}

final class OnClickNext extends AppEvent {
  final String name;

  OnClickNext({required this.name});
}

final class OnLoadLazy extends AppEvent {}

final class OnClickUserList extends AppEvent {
  final String selectedUser;
  OnClickUserList({required this.selectedUser});
}

final class OnClickNextThirdPage extends AppEvent {
  final String name;

  OnClickNextThirdPage({required this.name});
}

final class OnInputName extends AppEvent {
  final String inputName;
  OnInputName({required this.inputName});
}

final class OnInputPalindrome extends AppEvent {
  final String inputPalindrome;
  OnInputPalindrome({required this.inputPalindrome});
}
