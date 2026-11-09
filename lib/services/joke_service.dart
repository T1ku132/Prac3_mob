import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class JokeService {
    final Dio _dio = GetIt.instance<Dio>();

    Future<List<String>> fetchJokes() async {
        try {
            List<Future<Response>> futures = List.generate(
                5,
                    (_) => _dio.get('dadjokes'),
            );

            List<Response> responses = await Future.wait(futures);

            List<String> jokes = [];
            for (var response in responses) {
                final List<dynamic> data = response.data as List<dynamic>;
                jokes.add((data[0] as Map<String, dynamic>)['joke'] as String);
            }

            return jokes.toSet().toList();

        } on DioException catch (e) {
            print('ОШИБКА DIO: ${e.message}');
            return [];
        } catch (e) {
            print('НЕИЗВЕСТНАЯ ОШИБКА: $e');
            return [];
        }
    }
}