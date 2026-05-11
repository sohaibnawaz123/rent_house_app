import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/modules/onboarding/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:taxi_app/modules/onboarding/presentation/widget/onboarding_sample_view.dart';
import 'package:taxi_app/modules/onboarding/presentation/widget/pagination.dart';

class OnboardingView extends StatefulWidget {
  final OnboardingBloc bloc;
  const OnboardingView({super.key, required this.bloc});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    _pageController.dispose();
    super.dispose();
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

      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        bloc: widget.bloc,
        
        builder: (context, state) {
          final currentPage = state.currentPage;
          final isLastPage = currentPage == model.length - 1;

          return Stack(
            children: [
              PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (value) {
                  widget.bloc.add(ChangePageEvent(value));
                },
                itemCount: model.length,
                itemBuilder: (context, index) {
                  return OnboardingSampleView(model: model[index]);
                },
              ),
              //skip button
              if (currentPage != model.length - 1)
                Positioned(
                  top: context.pagePadding.top,
                  right: 20,
                  child: AppButton.textButton(
                    width: 76.w,
                    height: 40,
                    buttonColor: AppColor.transparent,
                    fontColor: AppColor.baseText,
                    borderColor: AppColor.baseText,
                    borderWidth: 1,
                    radius: 20,
                    title: 'Skip',
                    onTap: () {
                      widget.bloc.add(ChangePageEvent(model.length - 1));
                      _pageController.animateToPage(
                        model.length - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              if (currentPage > 0)
                Positioned(
                  top: context.pagePadding.top,
                  left: 20,
                  child: AppButton.iconButton(
                    iconPath: AppAsset.back,
                    width: 48.w,
                    height: 40,
                    buttonColor: AppColor.transparent,
                    fontColor: AppColor.baseText,
                    borderColor: AppColor.baseText,
                    borderWidth: 1,
                    radius: 20,

                    onTap: () {
                      final previousPage = currentPage - 1;
                      widget.bloc.add(PreviousPageEvent());
                      _pageController.animateToPage(
                        previousPage,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              //next button
              Positioned(
                bottom: context.pagePadding.bottom + 40,
                right: 20,
                left: isLastPage ? 20 : null,
                child: AppButton.textButton(
                  width: isLastPage ? null : 96.w,
                  height: 40,
                  buttonColor: AppColor.primary,
                  fontColor: AppColor.white,
                  borderColor: AppColor.primary,
                  borderWidth: 1,
                  radius: 20,
                  title: isLastPage ? 'Let\'s Start' : 'Next',
                  onTap: () {
                    if (isLastPage) {
                      return;
                    }

                    final nextPage = currentPage + 1;
                    widget.bloc.add(NextPageEvent(listLength: model.length));
                    _pageController.animateToPage(
                      nextPage,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
              // pagination
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom > 0
                    ? 20
                    : context.pagePadding.bottom,
                left: 0,
                right: 0,
                child: Pagination(
                  currentPage: currentPage,
                  totalPages: model.length,
                  width: 20,
                  height: 8,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
