import 'dart:async';

import 'package:rxdart/rxdart.dart';

CompositeSubscription staticCompositeSubscription = CompositeSubscription();

extension RxExtension<T> on Stream<T> {
  StreamSubscription<T> nothing() {
    return this.listen((event) {
      // Do nothing
    });
  }
}

extension StreamSubscriptionExtensions<T> on StreamSubscription<T> {
  void autoDispose() {
    this.addTo(staticCompositeSubscription);
  }
}
