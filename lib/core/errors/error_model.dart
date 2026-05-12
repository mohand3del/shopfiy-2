import 'package:flutter/widgets.dart';
import '../constant/api_key.dart';

class ErrorModel {
  final int? statusCode;
  final String message;
  final IconData? icon;
  final List<String>? errors; 

  ErrorModel({
    required this.statusCode,
    required this.message,
    this.icon,
    this.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    List<String>? extractedErrors;

    if (jsonData['errors'] != null) {
      final errorsMap = jsonData['errors'] as Map<String, dynamic>;
      extractedErrors = errorsMap.values
          .expand((value) => List<String>.from(value.map((e) => e.toString())))
          .toList();
    }

    return ErrorModel(
      statusCode: jsonData[ApiKey.statusCode],
      message: jsonData[ApiKey.message] ?? 'An unexpected error occurred',
      errors: extractedErrors,
    );
  }

  ErrorModel copyWith({
    int? statusCode,
    String? message,
    IconData? icon,
    List<String>? errors,
  }) {
    return ErrorModel(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      icon: icon ?? this.icon,
      errors: errors ?? this.errors,
    );
  }

  @override
  String toString() {
    return 'ErrorModel(statusCode: $statusCode, message: $message, errors: $errors)';
  }
}
