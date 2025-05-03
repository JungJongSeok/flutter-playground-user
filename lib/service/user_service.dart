import 'package:playground/service/request/user_request.dart';
import 'package:playground/service/response/user_response.dart';
import 'package:rxdart/rxdart.dart';

import 'base_service.dart';

class UserService extends BaseService {
  Stream<UserResponse> random(UserRequest request) {
    final String requestUrl= Uri.parse("$commonApiUrl/api").toString();
    return Rx.fromCallable(
      () => get(
        requestUrl,
        params: request.toJson(),
      ),
    ).map((event) => UserResponse.fromJson(event)).doOnData((data) {});
  }
}
