import 'package:flutter/material.dart';

abstract class MasterRepository {
  ///demo Api
  Future demoApi(BuildContext context, Map<String, dynamic> request);
}
