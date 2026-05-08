import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/onboarding/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:taxi_app/modules/onboarding/presentation/widget/onboarding_sample_view.dart';

class OnboardingView extends StatefulWidget {
  final OnboardingBloc bloc;
  const OnboardingView({super.key, required this.bloc});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  void initState() {
    super.initState();
  }

  final List<OnboardingSampleModel> model = [
    OnboardingSampleModel(
      assetPath: AppAsset.onboarding1,
      heading: 'Find the perfect place for your future house',
      text:
          'find the best place for your dream house with your family and loved ones',
    ),
    OnboardingSampleModel(
      assetPath: AppAsset.onboarding2,
      heading: 'Fast sell your property in just one click',
      text: 'Simplify the property sales process with just your smartphone',
    ),
    OnboardingSampleModel(
      assetPath: AppAsset.onboarding3,
      heading: 'Find your dream home with us',
      text: 'Just search and select your favorite property you want to locate',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.base,

      body: PageView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) {
          return OnboardingSampleView(model: model[index]);
        },
      ),
    );
  }
}
