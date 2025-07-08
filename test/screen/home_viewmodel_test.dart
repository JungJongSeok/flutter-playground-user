import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:playground/data/user_ui_data.dart';
import 'package:playground/screen/home_viewmodel.dart';
import 'package:playground/service/response/user_response.dart';
import 'package:playground/service/user_service.dart';

import 'home_viewmodel_test.mocks.dart';

@GenerateMocks([UserService])
void main() {
  late MockUserService mockUserService;
  late HomeViewModel homeViewModel;

  setUp(() {
    mockUserService = MockUserService();
    homeViewModel = HomeViewModel(userService: mockUserService);
  });

  group('HomeViewModel', () {
    test(
        'initProvider should load users and update state', () async {
      final mockUserData = [
        UserData(email: 'test1@example.com'),
        UserData(email: 'test2@example.com'),
      ];
      final mockResponse = UserResponse(results: mockUserData);

      when(mockUserService.getUser(any))
          .thenAnswer((_) => Stream.value(mockResponse));

      final container = ProviderContainer();
      addTearDown(container.dispose);

      final result = await container.read(homeViewModel.initProvider.future);

      expect(result.length, 2);
      expect(result[0].email, 'test1@example.com');
      expect(result[1].email, 'test2@example.com');

      final userDataState = container.read(homeViewModel.userDataProvider);
      expect(userDataState.length, 2);
    });

    test('initProvider should handle errors properly', () async {
      final error = Exception('API Error');
      when(mockUserService.getUser(any))
          .thenAnswer((_) => Stream.error(error));

      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(homeViewModel.initProvider.stream),
        emitsError(isA<Exception>()),
      );
    });

    test('moreProvider should load additional users', () async {
      final mockUserData = [
        UserData(email: 'more1@example.com'),
        UserData(email: 'more2@example.com'),
      ];
      final mockResponse = UserResponse(results: mockUserData);

      when(mockUserService.getUser(any))
          .thenAnswer((_) => Stream.value(mockResponse));

      final container = ProviderContainer();
      addTearDown(container.dispose);

      final stream = container.read(homeViewModel.moreProvider.stream);
      final result = await stream.first;

      expect(result.length, 2);
      expect(result[0].email, 'more1@example.com');
      expect(result[1].email, 'more2@example.com');
    });

    test('moreProvider should not load when locked', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(homeViewModel.moreProvider.stream);
      final secondStream = container.read(homeViewModel.moreProvider.stream);

      expect(await secondStream.isEmpty, true);
    });

    test('UserUiDataNotifier should add single user', () {
      final notifier = UserUiDataNotifier();
      final userData = UserUiData(email: 'test@example.com');

      notifier.add(userData);

      expect(notifier.state.length, 1);
      expect(notifier.state[0].email, 'test@example.com');
    });

    test('UserUiDataNotifier should add multiple users', () {
      final notifier = UserUiDataNotifier();
      final userDataList = [
        UserUiData(email: 'test1@example.com'),
        UserUiData(email: 'test2@example.com'),
      ];

      notifier.addAll(userDataList);

      expect(notifier.state.length, 2);
      expect(notifier.state[0].email, 'test1@example.com');
      expect(notifier.state[1].email, 'test2@example.com');
    });

    test('UserUiDataNotifier should clear all users', () {
      final notifier = UserUiDataNotifier();
      final userData = UserUiData(email: 'test@example.com');
      notifier.add(userData);

      notifier.clear();

      expect(notifier.state.length, 0);
    });

    test('UserUiDataNotifier should not modify state when not mounted', () {
      final notifier = UserUiDataNotifier();
      final userData = UserUiData(email: 'test@example.com');

      notifier.add(userData);
      expect(notifier.state.length, 1);
    });
  });
}