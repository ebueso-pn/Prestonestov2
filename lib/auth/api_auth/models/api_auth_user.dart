import '../../base_auth_user_provider.dart';

class ApiAuthUser implements BaseAuthUser {
  final AuthUserInfo _authUserInfo;

  ApiAuthUser({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) : _authUserInfo = AuthUserInfo(
          uid: uid,
          email: email,
          displayName: displayName,
          photoUrl: photoUrl,
          phoneNumber: phoneNumber,
        );

  @override
  bool get loggedIn => true;

  @override
  bool get emailVerified => true;

  @override
  AuthUserInfo get authUserInfo => _authUserInfo;

  @override
  String? get uid => _authUserInfo.uid;

  @override
  String? get email => _authUserInfo.email;

  @override
  String? get displayName => _authUserInfo.displayName;

  @override
  String? get photoUrl => _authUserInfo.photoUrl;

  @override
  String? get phoneNumber => _authUserInfo.phoneNumber;

  @override
  Future? delete() => null;

  @override
  Future? updateEmail(String email) => null;

  @override
  Future? sendEmailVerification() => null;

  @override
  Future refreshUser() async {}
}
