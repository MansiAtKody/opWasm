import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_logger.dart';

@module
abstract class DioLoggerModule {
  @LazySingleton(env: [Env.dev, Env.uat])
  DioLogger getDioLogger() {
    final dioLogger = DioLogger();
    return dioLogger;
  }
}
