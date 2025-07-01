import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseStateNotifier<T> extends StateNotifier<T> {
  final T data;

  BaseStateNotifier(this.data) : super(data);

  void set(T data) {
    if (!mounted) {
      return;
    }
    state = data;
  }

  T get() {
    return state;
  }
}