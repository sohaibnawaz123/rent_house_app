import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/instance.dart';
import 'package:taxi_app/modules/onboarding/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:taxi_app/modules/onboarding/presentation/routes/onboarding_view_initial_params.dart';
import 'package:taxi_app/modules/onboarding/presentation/views/onboarding_view.dart';

late GetIt getIt;

void main() {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getInstance(context);
    _onboardingBloc ??= getIt<OnboardingBloc>(
      param1: OnboardingViewInitialParams(),
    );
  }

  @override
  void dispose() {
    _onboardingBloc?.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Housely',
      home: ScreenUtilInit(
        designSize: const Size(402, 871),

        child: OnboardingView(
          bloc: _onboardingBloc!,
        ),
      ),
    );
  }
}
