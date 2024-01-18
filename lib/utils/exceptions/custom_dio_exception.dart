// import 'package:dio/dio.dart';

// class CustomDioException extends DioException {
//   CustomDioException({required super.requestOptions, this.message});
//   // final RequestOptions requestOptions;

//   // @override
//   // final Response? response;

//   // final DioErrorType type;

//   // final Object? error;

//   @override
//   final String? message;

//   // CustomError({
//   //   required this.requestOptions,
//   //   this.response,
//   //   this.type = DioErrorType.unknown,
//   //   this.error,
//   //   this.message,
//   // }) : super(requestOptions: requestOptions);
//   // @override
//   // String toString() {
//   //   String msg = '$message';
//   //   if (error != null) {
//   //     msg += '\nError: $error';
//   //   }
//   //   return msg;
//   // }

//   // @override
//   // DioError copyWith(
//   //     {RequestOptions? requestOptions,
//   //     Response? response,
//   //     DioErrorType? type,
//   //     Object? error,
//   //     StackTrace? stackTrace,
//   //     String? message}) {
//   //   // TODO: implement copyWith
//   //   throw UnimplementedError();
//   // }

//   // @override
//   // // TODO: implement stackTrace
//   // StackTrace get stackTrace => throw UnimplementedError();

//   @override
//   String toString() {
//     String msg = '$message';
//     if (error != null) {
//       msg += '\nError: $error';
//     }
//     return msg;
//   }
// }
