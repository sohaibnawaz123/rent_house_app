part of 'app_bloc.dart';

class AppState extends Equatable {
  final bool isInitialized;
  final bool isLoggedIn;
  final AppUserEntity user;
  final String accessToken;
  final String refreshToken;
  final CredentialsEntity credentials;

  const AppState({
    required this.isInitialized,
    required this.isLoggedIn,
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.credentials,
  });

  const AppState.initial()
    : isInitialized = false,
      isLoggedIn = false,
      user = const AppUserEntity.empty(),
      accessToken = '',
      refreshToken = '',
      credentials = const CredentialsEntity.empty();

  AppState copyWith({
    bool? isInitialized,
    bool? isLoggedIn,
    AppUserEntity? user,
    String? accessToken,
    String? refreshToken,
    CredentialsEntity? credentials,
  }) {
    return AppState(
      isInitialized: isInitialized ?? this.isInitialized,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      credentials: credentials ?? this.credentials,
    );
  }

  @override
  List<Object?> get props => [
    isInitialized,
    isLoggedIn,
    user,
    accessToken,
    refreshToken,
    credentials,
  ];
}
