part of 'app_bloc.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {
  final String name;
  final String palindrome;
  final String selectedName;
  final bool isPolindrome;
  bool checkPalindrome;
  bool checkNext;

  AppInitial({
    this.name = '',
    this.palindrome = '',
    this.selectedName = '',
    this.isPolindrome = false,
    this.checkPalindrome = false,
    this.checkNext = false,
  });

  AppInitial copyWith({
    String? palindrome,
    String? name,
    String? selectedName,
    bool? isPolindrome,
    bool? checkPalindrome,
    bool? checkNext,
  }) {
    return AppInitial(
      palindrome: palindrome ?? this.palindrome,
      name: name ?? this.name,
      selectedName: selectedName ?? this.selectedName,
      isPolindrome: isPolindrome ?? this.isPolindrome,
      checkPalindrome: checkPalindrome ?? this.checkPalindrome,
      checkNext: checkNext ?? this.checkNext,
    );
  }
}

final class AppLoggedUser extends AppState {
  final String name;
  final String selectedName;
  final List<UserModel> dataUser;
  bool checkNext;
  int page;
  bool isLoadingMore;
  bool clicked;

  AppLoggedUser({
    this.name = '',
    this.selectedName = '',
    this.dataUser = const [],
    this.checkNext = false,
    this.page = 1,
    this.isLoadingMore = true,
    this.clicked = false,
  });

  AppLoggedUser copyWith({
    String? name,
    String? selectedName,
    List<UserModel>? dataUser,
    bool? checkNext,
    int? page,
    bool? isLoadingMore,
    bool? clicked,
  }) {
    return AppLoggedUser(
      name: name ?? this.name,
      selectedName: selectedName ?? this.selectedName,
      dataUser: dataUser ?? this.dataUser,
      checkNext: checkNext ?? this.checkNext,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      clicked: clicked ?? this.clicked,
    );
  }
}

final class AppLoading extends AppState {}

final class AppFailed extends AppState {
  final String message;
  AppFailed({required this.message});
}
