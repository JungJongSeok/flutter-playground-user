// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkError _$NetworkErrorFromJson(Map<String, dynamic> json) => NetworkError(
      json['statusCode'] as int,
      json['errorResult'] == null
          ? null
          : ErrorResponse.fromJson(json['errorResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkErrorToJson(NetworkError instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'errorResult': instance.errorResult,
    };
