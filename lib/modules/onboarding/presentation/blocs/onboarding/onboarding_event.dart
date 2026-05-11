part of 'onboarding_bloc.dart';

sealed class OnboardingEvent {}

class LoadOnboardingEvent extends OnboardingEvent {
  final OnboardingParam param;
  LoadOnboardingEvent(this.param);
}

class ChangePageEvent extends OnboardingEvent {
  final int page;
  ChangePageEvent(this.page);
}

class NextPageEvent extends OnboardingEvent {
  final int listLength;
  NextPageEvent({required this.listLength});
}

class PreviousPageEvent extends OnboardingEvent {}
