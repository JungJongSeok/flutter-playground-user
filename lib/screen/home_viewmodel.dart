import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/screen/base_viewmodel.dart';
import 'package:playground/service/user_service.dart';
import 'package:rxdart/rxdart.dart';

import '../service/request/user_request.dart';
import '../service/response/user_response.dart';

class HomeViewModel extends BaseViewModel {
  final UserService userService;

  HomeViewModel({required this.userService});

  final StateNotifierProvider<UserDataNotifier, List<UserData>>
      userDataProvider =
      StateNotifierProvider<UserDataNotifier, List<UserData>>(
          (ref) => UserDataNotifier());

  Stream<List<UserData>> _home() {
    return userService
        .getUser(UserRequest(results: 10))
        .doOnData((data) {})
        .map((data) => data.results?.toList() ?? List.empty());
  }

  Stream<List<UserData>> _more() {
    if (_lock) {
      return Stream.empty();
    }
    _lock = true;
    return userService
        .getUser(UserRequest(results: 10))
        .doOnData((data) {})
        .map((data) => data.results?.toList() ?? List.empty());
  }

  late final initProvider = AutoDisposeStreamProvider<List<UserData>>((ref) {
    return _home().doOnData((data) {
      ref.read(userDataProvider.notifier).addAll(data);
    }).doOnError((error, stackTrace) {
      ref.read(networkErrorProvider.notifier)
        .alert(error, stackTrace: stackTrace);
    });
  });

  bool _lock = false;
  late final moreProvider = AutoDisposeStreamProvider<List<UserData>>((ref) {
    if (_lock) {
      return const Stream.empty();
    }
    _lock = true;
    return _home().doOnData((data) {
      ref.read(userDataProvider.notifier).addAll(data);
    }).doOnError((error, stackTrace) {
      ref.read(networkErrorProvider.notifier)
          .alert(error, stackTrace: stackTrace);
    }).doOnDone(() {
      _lock = false;
    });
  });
}

class UserDataNotifier extends StateNotifier<List<UserData>> {
  UserDataNotifier() : super([]);

  void add(UserData data) {
    if (!mounted) {
      return;
    }
    state = [...state, data];
  }

  void addAll(List<UserData> data) {
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
