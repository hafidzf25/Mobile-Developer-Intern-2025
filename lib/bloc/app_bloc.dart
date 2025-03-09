import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_developer_intern/data/repository/user_repository.dart';
import 'package:mobile_developer_intern/models/user_model.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserRepository userRepository;
  AppBloc(this.userRepository) : super(AppInitial()) {
    on<OnReset>((event, emit) {
      emit(AppInitial());
    });
    on<OnInputName>((event, emit) {
      emit((state as AppInitial).copyWith(name: event.inputName));
    });
    on<OnInputPalindrome>((event, emit) {
      emit((state as AppInitial).copyWith(palindrome: event.inputPalindrome));
    });
    on<OnClickCheck>((event, emit) {
      String cleanedText =
          event.palindrome
              .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
              .toLowerCase();
      String reversedText = cleanedText.split('').reversed.join('');
      bool isPol = cleanedText == reversedText;
      emit(
        AppInitial().copyWith(
          palindrome: event.palindrome,
          isPolindrome: isPol,
          checkPalindrome: true,
          name: event.name,
        ),
      );
    });
    on<OnClickNext>((event, emit) {
      emit(AppLoggedUser(name: event.name, checkNext: true));
    });
    on<OnClickNextThirdPage>((event, emit) async {
      try {
        final data = await userRepository.getCurrentUser(1);
        emit(
          (state as AppLoggedUser).copyWith(dataUser: data, checkNext: true),
        );
      } catch (e) {
        return emit(AppFailed(message: e.toString()));
      }
    });
    on<OnRefresh>((event, emit) async {
      final tempState = state;
      emit(AppLoading());
      try {
        final data = await userRepository.getCurrentUser(1);
        emit((tempState as AppLoggedUser).copyWith(dataUser: data));
      } catch (e) {
        return emit(AppFailed(message: e.toString()));
      }
    });
    on<OnLoadLazy>((event, emit) async {
      final tempState = state;
      try {
        List<UserModel> current = [];
        int index = 1;
        if (tempState is AppLoggedUser) {
          current = tempState.dataUser;
          index = tempState.page + 1;
          tempState.page++;
        }
        final data = await userRepository.getCurrentUser(index);
        current.addAll(data);
        if (data.length < 10) {
          emit(
            (tempState as AppLoggedUser).copyWith(
              dataUser: current,
              page: index,
              isLoadingMore: false,
            ),
          );
        } else {
          emit(
            (tempState as AppLoggedUser).copyWith(
              dataUser: current,
              page: index,
            ),
          );
        }
      } catch (e) {
        return emit(AppFailed(message: e.toString()));
      }
    });
    on<OnClickUserList>((event, emit) async {
      try {
        emit(
          (state as AppLoggedUser).copyWith(selectedName: event.selectedUser, clicked: true),
        );
      } catch (e) {
        return emit(AppFailed(message: e.toString()));
      }
    });
  }
}
