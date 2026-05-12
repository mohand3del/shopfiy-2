import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'error_model.dart';
import 'failure.dart';
import 'local_status_codes.dart';

class DioErrorHandler {
  Failure handle(dynamic e) {
    if (e is DioException) {
      return _handleDioError(e);
    }

    // (non-Dio)
    return Failure(
      
      error: ErrorModel(
        message: "An unexpected error occurred. Please try again.",
        statusCode: LocalStatusCodes.unknownError,
        icon: Icons.error_outline,
      ),
    );
  }

  Failure _handleDioError(DioException e) {
    final data = e.response?.data as Map<String, dynamic>? ?? {'message': e.message};
    final errorModel = ErrorModel.fromJson(data);

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(
          error: errorModel.copyWith(
            message: "Connection timed out. Please try again.",
            statusCode: LocalStatusCodes.connectionTimeout,
            icon: Icons.timer_off,
          ),
        );

      case DioExceptionType.sendTimeout:
        return Failure(
          error: errorModel.copyWith(
            message: "Request timed out while sending data.",
            statusCode: LocalStatusCodes.sendTimeout,
            icon: Icons.send,
          ),
        );

      case DioExceptionType.receiveTimeout:
        return Failure(
          error: errorModel.copyWith(
            message: "Server took too long to respond.",
            statusCode: LocalStatusCodes.receiveTimeout,
            icon: Icons.downloading,
          ),
        );

      case DioExceptionType.badCertificate:
        return Failure(
          error: errorModel.copyWith(
            message: "Untrusted SSL certificate. Please check your connection.",
            statusCode: LocalStatusCodes.badCertificate,
            icon: Icons.security,
          ),
        );

      case DioExceptionType.cancel:
        return Failure(
          error: errorModel.copyWith(
            message: "Request was cancelled.",
            statusCode: LocalStatusCodes.cancel,
            icon: Icons.cancel,
          ),
        );

      case DioExceptionType.connectionError:
        return Failure(
          error: errorModel.copyWith(
            message: "No internet connection. Please check your Wi-Fi or data.",
            statusCode: LocalStatusCodes.connectionError,
            icon: Icons.wifi_off,
          ),
        );

      case DioExceptionType.unknown:
        return Failure(
          error: errorModel.copyWith(
            message: "Unknown error occurred.",
            statusCode: LocalStatusCodes.unknownError,
            icon: Icons.error_outline,
          ),
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);
    }
  }

  Failure _handleBadResponse(DioException e) {
    final data = e.response?.data as Map<String, dynamic>? ?? {'message': e.message};
    final errorModel = ErrorModel.fromJson(data);

    final statusCode = e.response?.statusCode ?? LocalStatusCodes.unknownError;

    switch (statusCode) {
      case 400:
        return Failure(
          error: errorModel.copyWith(
            message: errorModel.message.isNotEmpty
                ? errorModel.message
                : "Bad request. Please check your input.",
            statusCode: LocalStatusCodes.badRequest,
            icon: Icons.report_problem,
            errors: errorModel.errors,
          ),
        );
      case 401:
        return Failure(
          error: errorModel.copyWith(
            message: errorModel.message.isNotEmpty
                ? errorModel.message
                : "Unauthorized access. Please log in.",
            statusCode: LocalStatusCodes.unauthorized,
            icon: Icons.lock_outline,
            errors: errorModel.errors,
          ),
        );
      case 403:
        return Failure(
          error: errorModel.copyWith(
            message: errorModel.message.isNotEmpty
                ? errorModel.message
                : "Forbidden. You don't have permission to access this resource.",
            statusCode: LocalStatusCodes.forbidden,
            icon: Icons.block,
            errors: errorModel.errors,
          ),
        );
      case 404:
        return Failure(
          error: errorModel.copyWith(
            message: errorModel.message.isNotEmpty
                ? errorModel.message
                : "Resource not found. Please check the URL.",
            statusCode: LocalStatusCodes.notFound,
            icon: Icons.search_off,
            errors: errorModel.errors,
          ),
        );
      case 409:
        return Failure(
          error: errorModel.copyWith(
            message: errorModel.message.isNotEmpty
                ? errorModel.message
                : "Conflict occurred. Please try again.",
            statusCode: LocalStatusCodes.conflict,
            icon: Icons.warning_amber,
            errors: errorModel.errors,
          ),
        );
      case 422:
        return Failure(
          error: errorModel.copyWith(
            message: errorModel.message.isNotEmpty
                ? errorModel.message
                : "Unprocessable entity. Please check your input.",
            statusCode: LocalStatusCodes.unprocessableEntity,
            icon: Icons.error,
            errors: errorModel.errors,
          ),
        );
      case 504:
        return Failure(
          error: errorModel.copyWith(
            message: errorModel.message.isNotEmpty
                ? errorModel.message
                : "Gateway timeout. Please try again later.",
            statusCode: LocalStatusCodes.gatewayTimeout,
            icon: Icons.cloud_off,
            errors: errorModel.errors,
          ),
        );
      default:
        return Failure(
          error: errorModel.copyWith(
            message: "Unexpected server error occurred.",
            statusCode: statusCode,
            icon: Icons.error_outline,
            errors: errorModel.errors,
          ),
        );
    }
  }
}
