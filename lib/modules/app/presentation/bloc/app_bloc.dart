import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/core/store/store_preference.dart';
import 'package:taxi_app/core/store/user_store_key.dart';
import 'package:taxi_app/core/utils/utils.dart';
import 'package:taxi_app/modules/app/domain/entitties/user_entity.dart';
import 'package:taxi_app/modules/auth/domain/entities/login_entity.dart';
import 'package:taxi_app/modules/auth/domain/params/refreshtoken_param.dart';
import 'package:taxi_app/modules/auth/domain/usecase/refreshtoken_use_case.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final StorePreference _store;
  final NetworkService _networkService;
  final RefreshtokenUseCase _refreshtokenUseCase;

  AppBloc({
    StorePreference? store,
    required NetworkService networkService,
    required RefreshtokenUseCase refreshtokenUseCase,
  })
    : _store = store ?? StorePreference(),
      _networkService = networkService,
      _refreshtokenUseCase = refreshtokenUseCase,
      super(const AppState.initial()) {
    on<ReadLocalUserEvent>(_readLocalUser);
    on<WriteLocalUserEvent>(_writeLocalUser);
    on<UpdateLocalUserTokenEvent>(_updateLocalUserToken);
    on<DeleteUserEvent>(_deleteUser);
    on<WriteCredentialsEvent>(_writeCredentials);
    on<ReadCredentialsEvent>(_readCredentials);
    on<DeleteCredentialsEvent>(_deleteCredentials);
    _setupAuthRefresh();
  }

  Future<void> _readLocalUser(
    ReadLocalUserEvent event,
    Emitter<AppState> emit,
  ) async {
    final isLoggedIn = _store
        .read<bool>(UserStoreKey.isLogin)
        .getOrElse((_) => false);
    final accessToken = _store
        .read<String>(UserStoreKey.accessToken)
        .getOrElse((_) => '');
    final refreshToken = _store
        .read<String>(UserStoreKey.refreshToken)
        .getOrElse((_) => '');
    final user = _store
        .read<Map<String, dynamic>>(UserStoreKey.userData)
        .map(AppUserEntity.fromJson)
        .getOrElse((_) => const AppUserEntity.empty());
    final credentials = _readStoredCredentials();

    emit(
      state.copyWith(
        isInitialized: true,
        isLoggedIn: isLoggedIn,
        accessToken: accessToken,
        refreshToken: refreshToken,
        user: user,
        credentials: credentials,
      ),
    );
  }

  Future<void> _writeLocalUser(
    WriteLocalUserEvent event,
    Emitter<AppState> emit,
  ) async {
    final user = AppUserEntity.fromAuthUser(event.data.user);
    final accessToken = event.data.accessToken ?? '';
    final refreshToken = event.data.refreshToken ?? '';

    _store.write<bool>(UserStoreKey.isLogin, true);
    _store.write<String>(UserStoreKey.accessToken, accessToken);
    _store.write<String>(UserStoreKey.refreshToken, refreshToken);
    _store.write<Map<String, dynamic>>(UserStoreKey.userData, user.toJson());

    Utils.logInfo(user.toString(), name: 'App Write User');

    emit(
      state.copyWith(
        isInitialized: true,
        isLoggedIn: true,
        user: user,
        accessToken: accessToken,
        refreshToken: refreshToken,
      ),
    );
  }

  Future<void> _updateLocalUserToken(
    UpdateLocalUserTokenEvent event,
    Emitter<AppState> emit,
  ) async {
    _store.write<String>(UserStoreKey.accessToken, event.accessToken);
    _store.write<String>(UserStoreKey.refreshToken, event.refreshToken);

    emit(
      state.copyWith(
        accessToken: event.accessToken,
        refreshToken: event.refreshToken,
      ),
    );
  }

  Future<void> _deleteUser(
    DeleteUserEvent event,
    Emitter<AppState> emit,
  ) async {
    _clearSessionStore();

    emit(
      state.copyWith(
        isInitialized: true,
        isLoggedIn: false,
        user: const AppUserEntity.empty(),
        accessToken: '',
        refreshToken: '',
      ),
    );
  }

  Future<void> _writeCredentials(
    WriteCredentialsEvent event,
    Emitter<AppState> emit,
  ) async {
    _store.write<Map<String, dynamic>>(
      UserStoreKey.rememberMe,
      event.data.toJson(),
    );

    emit(state.copyWith(credentials: event.data));
  }

  Future<void> _readCredentials(
    ReadCredentialsEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(credentials: _readStoredCredentials()));
  }

  Future<void> _deleteCredentials(
    DeleteCredentialsEvent event,
    Emitter<AppState> emit,
  ) async {
    _store.delete(UserStoreKey.rememberMe);
    emit(state.copyWith(credentials: const CredentialsEntity.empty()));
  }

  CredentialsEntity _readStoredCredentials() {
    return _store
        .read<Map<String, dynamic>>(UserStoreKey.rememberMe)
        .map(CredentialsEntity.fromJson)
        .getOrElse((_) => const CredentialsEntity.empty());
  }

  void _setupAuthRefresh() {
    _networkService.configureAuthRefresh(
      getAccessToken: () {
        return _store.read<String>(UserStoreKey.accessToken).getOrElse((_) => '');
      },
      refreshAccessToken: () async {
        final refreshToken = _store
            .read<String>(UserStoreKey.refreshToken)
            .getOrElse((_) => '');

        if (refreshToken.isEmpty) {
          return null;
        }

        final result = await _refreshtokenUseCase.execute(
          RefreshtokenParam(token: refreshToken),
        );

        return result.fold(
          (_) => null,
          (response) {
            final data = response.data;
            if (data.accessToken.isEmpty) {
              return null;
            }

            final latestRefreshToken = data.refreshToken.isNotEmpty
                ? data.refreshToken
                : refreshToken;

            _store.write<String>(UserStoreKey.accessToken, data.accessToken);
            _store.write<String>(UserStoreKey.refreshToken, latestRefreshToken);
            _store.write<bool>(UserStoreKey.isLogin, true);

            return data.accessToken;
          },
        );
      },
      clearSession: () async {
        _clearSessionStore();
      },
    );
  }

  void _clearSessionStore() {
    _store.delete(UserStoreKey.isLogin);
    _store.delete(UserStoreKey.accessToken);
    _store.delete(UserStoreKey.refreshToken);
    _store.delete(UserStoreKey.userData);
  }
}
