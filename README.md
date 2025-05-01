# playground

A new Flutter playground project.

## Json serializable

- Running the code generator
    - Once you have added the annotations to your code you then need to run the code generator to generate the missing .g.dart generated dart files.
        - With a Dart package, run `dart run build_runner build` in the package directory.
        - With a Flutter package, run `flutter pub run build_runner build` in your package directory.
        - if you want to watch auto-generated `flutter pub run build_runner watch --delete-conflicting-outputs`

- [Json serializable documentation](https://pub.dev/packages/json_serializable)


## Localize

If the build fails due to l10n import, flutter keyword application is required.
```
$ flutter gen-l10n
```
- [Localization documentation](https://phrase.com/blog/posts/flutter-localization/)


## Questions/issues

- [Flutter documentation](https://flutter.dev/)
- [StackOverflow](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter sample](https://github.com/flutter/samples).
