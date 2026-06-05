import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/core/store/store_preference.dart';
import 'package:taxi_app/core/store/user_store_key.dart';
import 'package:taxi_app/instance.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/login/login_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/login_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/views/login_view.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardroot_view_initial_params.dart';
import 'package:taxi_app/modules/dashboard/presentation/views/dashboardroot_view.dart';
import 'package:taxi_app/modules/googlemap/domain/entities/locationpick_entity.dart';
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
  OnboardingBloc? _onboardingBloc;
  LoginBloc? _loginBloc;
  DashboardrootBloc? _dashboardrootBloc;

  LocationpickEntity get _defaultLocation => const LocationpickEntity(
    lat: 0.0,
    lon: 0.0,
    city: '',
    state: '',
    country: '',
    zipCode: '',
    addressLine: '',
    countryCode: '',
    provinceCode: '',
  );

  LocationpickEntity get _storedLocation {
    return StorePreference()
        .read<Map<String, dynamic>>(UserStoreKey.location)
        .map(LocationpickEntity.fromJson)
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
    _onboardingBloc?.close();
    _loginBloc?.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isOnboardingDone = StorePreference()
        .read<bool>(UserStoreKey.isOnboarding)
        .getOrElse((_) => false);
    final isLogiDone = StorePreference()
        .read<bool>(UserStoreKey.isLogin)
        .getOrElse((_) => false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Housely',
      home: ScreenUtilInit(
        designSize: const Size(402, 871),
        child: isOnboardingDone
            ? isLogiDone
                  ? DashboardrootView(bloc: _dashboardrootBloc!)
                  : LoginView(bloc: _loginBloc!)
            : OnboardingView(bloc: _onboardingBloc!),
      ),
    );
  }
}
