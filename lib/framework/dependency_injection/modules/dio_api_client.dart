import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_logger.dart';


@module
abstract class NetworkModule {
  @LazySingleton(env: [Env.uat])
  DioClient getProductionDioClient(DioLogger dioLogger) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://service.dasher.kodytechnolab.com/dasher',
      ),
    );
   // dio.interceptors.add(networkInterceptor());
    dio.interceptors.add(dioLogger);
    final client = DioClient(dio);
    return client;
  }

  @LazySingleton(env: [Env.dev])
  DioClient getDebugDioClient(DioLogger dioLogger) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://service.dasher.kodytechnolab.com/dasher',
      ),
    );
    //dio.interceptors.add(networkInterceptor());
    dio.interceptors.add(dioLogger);
    final client = DioClient(dio);
    return client;
  }



}

