import 'package:http/http.dart' as http;

class UserDataProvider {
  Future<String> getCurrentUser(int page) async {
    try {
      // Get data string
      final res = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$page&per_page=10'),
      );
      
      if (res.statusCode != 200) {
        throw 'Error';
      }

      // Lempar ke repository

      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
