import 'package:flutter/widgets.dart';

import 'error_model.dart';

class Failure {
  final ErrorModel error;

  const Failure({required this.error});

  String get message => error.message;
  int? get statusCode => error.statusCode;
  IconData? get icon => error.icon;
  List<String>? get errors => error.errors;

  @override
  String toString() => 'Failure(message: $message, status: $statusCode)';
}
