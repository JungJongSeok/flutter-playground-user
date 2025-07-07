import '../service/response/user_response.dart';

class UserUiData {
  final String? email;

  UserUiData({
    this.email,
  });
}

extension UserUiDataExtension on UserData {
  UserUiData toUiData() {
    return UserUiData(
      email: email,
    );
  }
}
