import 'package:json_annotation/json_annotation.dart';

import '../base_service.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse implements JsonSerializer {
  final String? message;

  ErrorResponse({
    required this.message,
  });

  @override
  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return _$ErrorResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ErrorResponseToJson(this);
  }
}
