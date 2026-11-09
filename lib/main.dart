import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'interceptors/logging_interceptor.dart';
import 'services/joke_service.dart';
import 'widgets/joke_list.dart';

final getIt = GetIt.instance;

void setupService() {
  getIt.registerLazySingleton<Dio>(() => Dio(
    BaseOptions(
      baseUrl: 'https://api.api-ninjas.com/v1/',
    ),
  )..interceptors.addAll([
    LoggingInterceptor('H57D8Vx2KOzDbTg6NsiN87Hwc3leSHiaJgRgvxSx'),
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
  ]));

  getIt.registerLazySingleton<JokeService>(() => JokeService());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupService();
  runApp(const JokeApp());
}

class JokeApp extends StatelessWidget {
  const JokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dad Jokes App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Батины шутки')),
        body: const JokeList(),
      ),
    );
  }
}