import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:playground/service/request/user_request.dart';
import 'package:playground/service/response/user_response.dart';
import 'package:playground/service/user_service.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([UserService])
void main() {
  late MockUserService userService;

  setUp(() {
    userService = MockUserService();
  });

  group('UserService', () {
    test('getUser returns UserResponse on successful request', () async {
      // Arrange
      final userRequest = UserRequest(results: 10);
      final mockResponse = {
        'results': [
          {
            'gender': 'male',
            'name': {'first': 'John', 'last': 'Doe'}
          },
          {
            'gender': 'female',
            'name': {'first': 'Jane', 'last': 'Doe'}
          },
        ],
        'info': {'seed': 'abc', 'results': 2, 'page': 1, 'version': '1.0'},
      };
      when(userService.getUser(userRequest))
          .thenAnswer((_) => Stream.value(UserResponse.fromJson(mockResponse)));

      // Act
      final userResponse = await userService.getUser(userRequest).single;

      // Assert
      expect(userResponse.results?.length, 2);
      expect(userResponse.results?[0].gender, 'male');
      expect(userResponse.results?[0].name?.first, 'John');
      expect(userResponse.results?[1].gender, 'female');
      expect(userResponse.results?[1].name?.first, 'Jane');
    });

    test('getUser throws an exception on failed request', () async {
      // Arrange
      final userRequest = UserRequest(results: 5);
      const errorMessage = 'Failed to fetch users';
      when(userService.getUser(userRequest))
          .thenAnswer((_) => Stream.value(throw Exception(errorMessage)));

      // Act & Assert
      expect(() => userService.getUser(userRequest), throwsException);
    });
  });
}
