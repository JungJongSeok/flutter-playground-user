import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../extensions/collection.dart';
import '../utils/base_state_notifier.dart';
import '../service/network_error.dart';


class BaseViewmodel {
  final StateNotifierProvider<NetworkErrorNotifier,
      Pair<Object, StackTrace?>> networkErrorProvider =
  StateNotifierProvider<NetworkErrorNotifier,
      Pair<Object, StackTrace?>>((ref) => NetworkErrorNotifier());

  final BaseStateNotifier<bool> loadingNotifier = BaseStateNotifier(false);

  void dispose() {
    loadingNotifier.dispose();
  }
}