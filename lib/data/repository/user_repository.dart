import 'dart:convert';

import 'package:mobile_developer_intern/data/data_provider/user_data_provider.dart';
import 'package:mobile_developer_intern/models/user_model.dart';

class UserRepository {
  final UserDataProvider userDataProvider;
  UserRepository({required this.userDataProvider});

  Future<List<UserModel>> getCurrentUser(int page) async {
    try {
      final userData = await userDataProvider.getCurrentUser(page);
      final data = jsonDecode(userData);

      List<UserModel> fixData = [];
      for (var i = 0; i < (data['data'] as List).length; i++) {
        fixData.add(UserModel.fromMap(data['data'][i]));
      }

      return fixData;
    } catch (e) {
      throw e.toString();
    }
  }
}
