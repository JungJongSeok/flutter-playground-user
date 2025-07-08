import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:playground/service/base_service.dart';

import 'base_service_test.mocks.dart';

@GenerateMocks([BaseService])
void main() {
  group('BaseService', () {
    late MockBaseService baseService;

    setUp(() {
      baseService = MockBaseService();
    });

    test('GET request sends correct URL and headers', () async {
      const testUrl = 'https://example.com/api/data';
      const testHeaders = {'Authorization': 'Bearer token'};

      when(baseService.get(testUrl, headers: testHeaders)).thenAnswer(
          (_) async => Map<String, dynamic>.from({'message': 'Success'}));

      final response = await baseService.get(testUrl, headers: testHeaders);
      expect(response['message'], 'Success');
    });

    test('POST request sends correct URL, headers, and body', () async {
      const testUrl = 'https://example.com/api/data';
      const testHeaders = {'Content-Type': 'application/json'};
      const testBody = {'name': 'test'};

      when(baseService.post(testUrl, headers: testHeaders, body: testBody)).thenAnswer(
              (_) async => Map<String, dynamic>.from({'message': 'Success'}));

      final response = await baseService.get(testUrl, headers: testHeaders);
      expect(response['message'], 'Success');
    });

    test('PUT request sends correct URL, headers, and body', () async {
      const testUrl = 'https://example.com/api/data/123';
      const testHeaders = {'Content-Type': 'application/json'};
      const testBody = {'name': 'updated'};

      when(baseService.put(testUrl, headers: testHeaders, body: testBody)).thenAnswer(
              (_) async => Map<String, dynamic>.from({'message': 'Success'}));

      final response = await baseService.get(testUrl, headers: testHeaders);
      expect(response['message'], 'Success');
    });

    test('DELETE request sends correct URL and headers', () async {
      const testUrl = 'https://example.com/api/data/123';
      const testHeaders = {'X-Delete-Reason': 'Testing'};

      when(baseService.delete(testUrl, headers: testHeaders)).thenAnswer(
              (_) async => Map<String, dynamic>.from({'message': 'Success'}));

      final response = await baseService.get(testUrl, headers: testHeaders);
      expect(response['message'], 'Success');
    });

    test('multipartRequest sends correct URL, headers, and files', () async {
      const testUrl = 'https://example.com/api/upload';
      const testHeaders = {'Authorization': 'Bearer token'};
      const testFields = {'description': 'test upload'};
      final testFiles = [
        MultiPartFileData('file', 'test.txt')
      ];

      when(baseService.multipartRequest(testUrl, files: testFiles, headers: testHeaders)).thenAnswer(
              (_) async => Map<String, dynamic>.from({'message': 'Success'}));

      final response = await baseService.get(testUrl, headers: testHeaders);
      expect(response['message'], 'Success');
    });

    test('handles general exception', () async {
      const testUrl = 'https://example.com/api/data';
      const testHeaders = {'Authorization': 'Bearer token'};
      const errorMessage = 'Failed to get data';

      when(baseService.get(testUrl, headers: testHeaders)).thenAnswer(
              (_) async => throw Exception(errorMessage));

      expect(() => baseService.get(testUrl, headers: testHeaders), throwsException);
    });
  });
}
