import 'package:flutter/material.dart';

extension PageControllerExtension on PageController {
  Future<void> circularNextPage(int size,
      {required Duration duration, required Curve curve}) {
    if (size <= page!.round() + 1) {
      return Future.sync(() => jumpToPage(0));
    } else {
      return nextPage(duration: duration, curve: curve);
    }
  }
  Future<void> circularAnimateToPage(int size, int currentPage,
      {required Duration duration, required Curve curve}) {
    if (size <= currentPage + 1) {
      return Future.sync(() => jumpToPage(0));
    } else {
      return animateToPage(currentPage + 1, duration: duration, curve: curve);
    }
  }
}
