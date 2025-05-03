import 'package:json_annotation/json_annotation.dart';

import '../base_service.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest implements JsonSerializer {
  final int results;

  UserRequest({required this.results});

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}
