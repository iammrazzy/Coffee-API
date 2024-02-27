import 'dart:io';
import 'package:coffee_api/models/cofffee_model.dart';
import 'package:dio/dio.dart';

class APIService {
  final _dio = Dio();
  final String _baseURL = 'https://fake-coffee-api.vercel.app';

  // get coffee
  Future<List<CoffeeModel>> fetchCoffee() async {
    try {
      final response = await _dio.get(
        '$_baseURL/api',
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Status code: ${response.statusCode}');
        print('Success...! Coffee Data: 👉 ${response.data}');
        List<dynamic> coffeeDataList = response.data;
        List<CoffeeModel> coffeeList = coffeeDataList.map((json) {
          return CoffeeModel.fromJson(json);
        }).toList();
        return coffeeList;
      } else {
        print('Status code: ${response.statusCode}');
        print('Error...! Server response: 👉 ${response.data}');
        throw Exception('Failed to fetch coffee. Please try again.');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.statusCode} - ${e.message}');
        throw Exception('Failed to fetch coffee data. Please try again.');
      } else {
        print('Error: $e');
        throw Exception('An unexpected error occurred. Please try again.');
      }
    }
  }
}
