import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/core/store/store_preference.dart';
import 'package:taxi_app/core/store/user_store_key.dart';
import 'package:taxi_app/instance.dart';
import 'package:taxi_app/modules/app/presentation/bloc/app_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/login/login_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/login_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/views/login_view.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardroot_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardroot_view.dart';
import 'package:taxi_app/modules/googlemap/data/model/response/locationpick_model/locationpick_model.dart';
import 'package:taxi_app/modules/onboarding/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:taxi_app/modules/onboarding/presentation/routes/onboarding_view_initial_params.dart';
import 'package:taxi_app/modules/onboarding/presentation/views/onboarding_view.dart';

late GetIt getIt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorePreference.create();
  getIt = GetIt.instance;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppBloc _appBloc;
  OnboardingBloc? _onboardingBloc;
  LoginBloc? _loginBloc;
  DashboardrootBloc? _dashboardrootBloc;

  @override
  void initState() {
    super.initState();
    _appBloc = AppBloc()..add(const ReadLocalUserEvent());
  }

  LocationpickModel get _defaultLocation => const LocationpickModel(
    lat: 0.0,
    lon: 0.0,
    city: '',
    state: '',
    country: '',
    zipcode: '',
    addressline: '',
    countrycode: '',
    provincecode: '',
  );

  LocationpickModel get _storedLocation {
    return StorePreference()
        .read<Map<String, dynamic>>(UserStoreKey.location)
        .map(LocationpickModel.fromJson)
        .getOrElse((_) => _defaultLocation);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getInstance(context);
    _onboardingBloc ??= getIt<OnboardingBloc>(
      param1: OnboardingViewInitialParams(),
    );
    _dashboardrootBloc ??= getIt<DashboardrootBloc>(
      param1: DashboardrootViewInitialParams(location: _storedLocation),
    );
    _loginBloc ??= getIt<LoginBloc>(param1: LoginViewInitialParams());
  }

  @override
  void dispose() {
    _appBloc.close();
    _onboardingBloc?.close();
    _loginBloc?.close();
    _dashboardrootBloc?.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isOnboardingDone = StorePreference()
        .read<bool>(UserStoreKey.isOnboarding)
        .getOrElse((_) => false);

    return BlocProvider.value(
      value: _appBloc,
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Housely',
            home: ScreenUtilInit(
              designSize: const Size(402, 871),
              child: _buildInitialView(appState, isOnboardingDone),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitialView(AppState appState, bool isOnboardingDone) {
    if (!appState.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!isOnboardingDone) {
      return OnboardingView(bloc: _onboardingBloc!);
    }

    if (!appState.isLoggedIn) {
      return LoginView(bloc: _loginBloc!);
    }

    return DashboardrootView(bloc: _dashboardrootBloc!);
  }
}
