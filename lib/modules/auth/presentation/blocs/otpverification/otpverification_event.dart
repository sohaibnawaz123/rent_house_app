part of 'otpverification_bloc.dart';

sealed class OtpverificationEvent {}

class  LoadOtpverificationEvent extends OtpverificationEvent {
  final OtpverificationParam param;
   LoadOtpverificationEvent(this.param);
}
