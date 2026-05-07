// import 'package:fpdart/fpdart.dart';
// import 'package:taxi_app/core/failures/network_failure.dart';
// import 'package:taxi_app/core/network/network.dart';
// import 'package:taxi_app/data/network/network.dart';
// import 'package:taxi_app/domain/entities/auth/token_refresh_entity.dart';
// import 'package:taxi_app/domain/failures/network_failure.dart';
// import 'package:taxi_app/domain/usecase/auth/token_refresh_use_case.dart';
// import 'package:taxi_app/features/app/app/bloc/bloc/app_bloc.dart';
// import 'package:taxi_app/core/utils/utils.dart';

// class NetworkHandler {
//   final Network network;
//   final TokenRefreshUseCase refreshUseCase;
//   final AppBloc appBloc;
//   NetworkHandler(this.network, this.refreshUseCase, this.appBloc);

//   Future<Either<NetworkFailure, dynamic>> get(
//     String url,
//     Map<String, String>? header, {
//     Map<String, dynamic>? query,
//     String? pathVariable,
//   }) async {
//     final result = await network.get(
//       url,
//       header,
//       query: query,
//       pathVariable: pathVariable,
//     );
//     return await result.fold(
//       (l) => _handleTokenRefreshAndRetry(
//         (updatedHeader) => network.get(
//           url,
//           updatedHeader,
//           query: query,
//           pathVariable: pathVariable,
//         ),
//         l,
//         header,
//       ),
//       (response) async => right(response),
//     );
//   }

//   Future<Either<NetworkFailure, dynamic>> post(
//     String url,
//     Map<String, dynamic> data,
//     Map<String, String>? header, {
//     String? pathVariable,
//   }) async {
//     final result = await network.post(
//       url,
//       data,
//       header,
//       pathVariable: pathVariable,
//     );
//     return await result.fold(
//       (l) => _handleTokenRefreshAndRetry(
//         (updatedHeader) =>
//             network.post(url, data, updatedHeader, pathVariable: pathVariable),
//         l,
//         header,
//       ),
//       (response) async => right(response),
//     );
//   }

//   Future<Either<NetworkFailure, dynamic>> patch(
//     String url,
//     Map<String, dynamic> data,
//     Map<String, String>? header, {
//     String? pathVariable,
//   }) async {
//     final result = await network.patch(
//       url,
//       data,
//       header,
//       pathVariable: pathVariable,
//     );
//     return await result.fold(
//       (l) => _handleTokenRefreshAndRetry(
//         (updatedHeader) =>
//             network.patch(url, data, updatedHeader, pathVariable: pathVariable),
//         l,
//         header,
//       ),
//       (response) async => right(response),
//     );
//   }

//   Future<Either<NetworkFailure, dynamic>> put(
//     String url,
//     Map<String, dynamic> data,
//     Map<String, String>? header, {
//     String? pathVariable,
//   }) async {
//     final result = await network.put(
//       url,
//       data,
//       header,
//       pathVariable: pathVariable,
//     );
//     return await result.fold(
//       (l) => _handleTokenRefreshAndRetry(
//         (updatedHeader) =>
//             network.put(url, data, updatedHeader, pathVariable: pathVariable),
//         l,
//         header,
//       ),
//       (response) async => right(response),
//     );
//   }

//   Future<Either<NetworkFailure, dynamic>> postFile(
//     String url,
//     Map<String, dynamic> data,
//     Map<String, dynamic> file,
//     Map<String, String>? header, {
//     String? pathVariable,
//   }) async {
//     final result = await network.postFile(
//       url,
//       data,
//       file,
//       header,
//       pathVariable: pathVariable,
//     );
//     return await result.fold(
//       (l) => _handleTokenRefreshAndRetry(
//         (updatedHeader) => network.postFile(
//           url,
//           data,
//           file,
//           updatedHeader,
//           pathVariable: pathVariable,
//         ),
//         l,
//         header,
//       ),
//       (response) async => right(response),
//     );
//   }

//   Future<Either<NetworkFailure, dynamic>> patchFile(
//     String url,
//     Map<String, dynamic> data,
//     Map<String, dynamic> file,
//     Map<String, String>? header, {
//     String? pathVariable,
//   }) async {
//     final result = await network.patchFile(
//       url,
//       data,
//       file,
//       header,
//       pathVariable: pathVariable,
//     );
//     return await result.fold(
//       (l) => _handleTokenRefreshAndRetry(
//         (updatedHeader) => network.patchFile(
//           url,
//           data,
//           file,
//           updatedHeader,
//           pathVariable: pathVariable,
//         ),
//         l,
//         header,
//       ),
//       (response) async => right(response),
//     );
//   }

//   Future<Either<NetworkFailure, dynamic>> putFile(
//     String url,
//     Map<String, dynamic> data,
//     Map<String, dynamic> file,
//     Map<String, String>? header, {
//     String? pathVariable,
//   }) async {
//     final result = await network.putFile(
//       url,
//       data,
//       file,
//       header,
//       pathVariable: pathVariable,
//     );
//     return await result.fold(
//       (l) => _handleTokenRefreshAndRetry(
//         (updatedHeader) => network.putFile(
//           url,
//           data,
//           file,
//           updatedHeader,
//           pathVariable: pathVariable,
//         ),
//         l,
//         header,
//       ),
//       (response) async => right(response),
//     );
//   }

//   Future<Either<NetworkFailure, dynamic>> delete(
//     String url,
//     Map<String, String>? header, {
//     Map<String, dynamic>? query,
//     String? pathVariable,
//   }) async {
//     final result = await network.delete(
//       url,
//       header,
//       query: query,
//       pathVariable: pathVariable,
//     );
//     return await result.fold(
//       (l) => _handleTokenRefreshAndRetry(
//         (updatedHeader) => network.delete(
//           url,
//           updatedHeader,
//           query: query,
//           pathVariable: pathVariable,
//         ),
//         l,
//         header,
//       ),
//       (response) async => right(response),
//     );
//   }

//   Future<Either<NetworkFailure, dynamic>> _handleTokenRefreshAndRetry(
//     Future<Either<NetworkFailure, dynamic>> Function(
//       Map<String, String>? header,
//     )
//     request,
//     NetworkFailure failure,
//     Map<String, String>? header,
//   ) async {
//     if (failure.error == 'Invalid or Expired Token') {
//       final refreshResult = await refreshUseCase.execute(
//         TokenRefreshEntity(refreshToken: appBloc.state.user.refreshToken),
//       );

//       return await refreshResult.fold(
//         (error) => left(NetworkFailure(error.error)),
//         (refreshData) async {
//           appBloc.add(UpdateLocalUserTokenEvent(refreshData.data));
//           header?['Authorization'] = "Bearer ${refreshData.data.accessToken}";
//           Utils.logInfo(header.toString(), name: "Updated Header");

//           final retryResult = await request(header);
//           return retryResult.fold((err) {
//             if (err.runtimeType == UnAuthorizedFailure) {
//               appBloc.add(DeleteUserEvent());
//             }
//             return left(NetworkFailure(err.error));
//           }, (v) => right(v));
//         },
//       );
//     } else {
//       if (failure.runtimeType == UnAuthorizedFailure) {
//         appBloc.add(DeleteUserEvent());
//       }
//       return left(NetworkFailure(failure.error.toString()));
//     }
//   }
// }
