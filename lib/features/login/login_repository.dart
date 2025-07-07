import 'package:induk/common/repository/token_repository.dart';
import 'package:induk/common/models/user.dart';
import 'login_api_provider.dart';

class LoginRepository {
  LoginRepository({LoginApiProvider? loginApiProvider})
      : _loginApiProvider = loginApiProvider ?? LoginApiProvider();

  final LoginApiProvider _loginApiProvider;

  Future<bool> login({required String id, required String pwd}) async {
    try {
      final loginJson = await _loginApiProvider.requestLogin(id: id, pwd: pwd);
      final user = User.fromJson(loginJson);

      // accessToken
      final accessToken = loginJson["data"]["accessToken"];
      if (accessToken == null) return false;

      // accessToken 저장
      await TokenRepository().saveAccessToken(accessToken);
      return true;
    } catch (_) {
      return false;
    }
  }

  void dispose() {
    _loginApiProvider.close();
  }
}