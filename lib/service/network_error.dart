import 'dart:convert';

import 'package:debug_logger/debug_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:playground/extensions/collection.dart';
import 'package:playground/service/response/error_response.dart';

import '../utils/custom_widget.dart';
import 'base_service.dart';

part 'network_error.g.dart';

@JsonSerializable()
class NetworkError extends Error implements JsonSerializer {
  static const int _CODE_UNAUTHORIZED = 401;

  final int statusCode;
  final ErrorResponse? errorResult;

  NetworkError(this.statusCode, this.errorResult);

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  @override
  factory NetworkError.fromJson(Map<String, dynamic> json) {
    return _$NetworkErrorFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$NetworkErrorToJson(this);
  }

  static NetworkError? parse(Error error) {
    try {
      return NetworkError.fromJson(jsonDecode(error.toString()));
    } catch (error) {
      return null;
    }
  }

  static void navigateErrorState(BuildContext context, Object error,
      {StackTrace? stackTrace = null}) {
    if (error is Error) {
      _navigateErrorState(context, error, stackTrace ?? StackTrace.current);
    } else {
      _navigateErrorState(
          context, StateError(error.toString()), StackTrace.current);
    }
  }

  static void _navigateErrorState(
      BuildContext context, Error error, StackTrace? stackTrace) {
    NetworkError? networkError = parse(error);
    if (networkError != null) {
      if (networkError.statusCode == _CODE_UNAUTHORIZED) {
        CustomWidget.showToast(networkError.errorResult?.message ??
            AppLocalizations.of(context)!.error_message_unauthorized);
      }
    }
    showErrorToast(context, error, stackTrace);
  }

  static void showErrorToast(
      BuildContext context, Error error, StackTrace? stackTrace) {
    DebugLogger.error(stackTrace);
    NetworkError? networkError = parse(error);
    if (networkError != null) {
      CustomWidget.showToast(networkError.errorResult?.message ??
          AppLocalizations.of(context)!.error_response_default_fail_message);
    } else {
      CustomWidget.showToast(
          AppLocalizations.of(context)!.error_response_default_fail_message);
    }
  }
}

class NetworkErrorNotifier extends StateNotifier<Pair<Object, StackTrace?>> {
  NetworkErrorNotifier() : super(Pair(Object, null));

  void alert(Object error, {StackTrace? stackTrace}) {
    if (!mounted) {
      return;
    }
    state = Pair(error, stackTrace);
  }
}
