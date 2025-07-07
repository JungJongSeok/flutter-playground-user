import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../data/user_ui_data.dart';
import '../service/request/user_request.dart';
import '../service/user_service.dart';
import 'base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final UserService userService;

  HomeViewModel({required this.userService});

  final StateNotifierProvider<UserUiDataNotifier, List<UserUiData>>
      userDataProvider =
      StateNotifierProvider<UserUiDataNotifier, List<UserUiData>>(
          (ref) => UserUiDataNotifier());

  Stream<List<UserUiData>> _home() {
    return userService
        .getUser(UserRequest(results: 20))
        .doOnData((data) {})
        .map((data) =>
            data.results?.map((data) => data.toUiData()).toList() ??
            List.empty());
  }

  late final initProvider = AutoDisposeStreamProvider<List<UserUiData>>((ref) {
    return _home().doOnData((data) {
      ref.read(userDataProvider.notifier).addAll(data);
    }).doOnError((error, stackTrace) {
      ref
          .read(networkErrorProvider.notifier)
          .alert(error, stackTrace: stackTrace);
    });
  });

  bool _lock = false;
  late final moreProvider = AutoDisposeStreamProvider<List<UserUiData>>((ref) {
    if (_lock) {
      return const Stream.empty();
    }
    _lock = true;
    return _home().doOnData((data) {
      ref.read(userDataProvider.notifier).addAll(data);
    }).doOnError((error, stackTrace) {
      ref
          .read(networkErrorProvider.notifier)
          .alert(error, stackTrace: stackTrace);
    }).doOnDone(() {
      _lock = false;
    });
  });
}

class UserUiDataNotifier extends StateNotifier<List<UserUiData>> {
  UserUiDataNotifier() : super([]);

  void add(UserUiData data) {
    if (!mounted) {
      return;
    }
    state = [...state, data];
  }

  void addAll(List<UserUiData> data) {
    if (!mounted) {
      return;
    }
    state = state + data;
  }

  void clear() {
    if (!mounted) {
      return;
    }
    state = List.empty();
  }
}
