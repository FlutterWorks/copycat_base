import 'package:copycat_base/common/failure.dart';
import 'package:copycat_base/domain/model/auth_user/auth_user.dart';

abstract class AuthRepository {
  FailureOr<(String?, AuthUser?)> validateAuthCode(String code);
  FailureOr<void> logout();
  FailureOr<AuthUser> updateUserInfo(Map<String, dynamic> data);
  String? get userId;
  AuthUser? get currentUser;
  String? get accessToken;
}
