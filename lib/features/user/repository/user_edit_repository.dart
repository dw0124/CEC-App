import 'package:induk/common/error/error_mapper.dart';
import 'package:induk/common/models/result.dart';
import 'package:induk/common/network/http_response_handler.dart';
import 'package:induk/features/user/provider/user_edit_provider.dart';

class UserEditRepository {
  UserEditRepository({UserEditProvider? userEditProvider})
      : _userEditProvider = userEditProvider ?? UserEditProvider();

  final UserEditProvider _userEditProvider;

  Future<Result<void>> updateUserInfoRequest({
    required String name,
    required String phoneNumber,
    required String nickname,
    String? newPassword,
    String? confirmPassword,
    required String profilePicture,
  }) async {
    try {
      final response = await _userEditProvider.updateUserInfoRequest(
          name: name,
          phoneNumber: phoneNumber,
          nickname: nickname,
          profilePicture: profilePicture
      );
      final jsonResponse = httpResponseHandler(response);
      return Result.success(null);
    } catch (e) {
      return ErrorMapper.toFailure(e);
    }
  }

  void dispose() {
    _userEditProvider.close();
  }
}