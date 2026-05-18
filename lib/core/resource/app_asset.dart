class AppAsset {
  AppAsset._internal();
  static final AppAsset _instance = AppAsset._internal();

  factory AppAsset() {
    return _instance;
  }
  static const String iconPath = 'assets/icons';
  static const String imagePath = 'assets/images';
  static const String illustrationPath = 'assets/illustration';
  static const String lottiePath = 'assets/lottie';

  static const String applogo = '$imagePath/logo-icon.png';

  //onboarding
  //onboarding images
  static const String onboarding1 = '$imagePath/onboarding_one.png';
  static const String onboarding2 = '$imagePath/onboarding_two.png';
  static const String onboarding3 = '$imagePath/onboarding_three.png';

  //icons
  static const String eye = '$iconPath/eye.svg';
  static const String eyeoff = '$iconPath/eye-off.svg';
  static const String back = '$iconPath/back.svg';
  static const String info = '$iconPath/Paper.svg';
  static const String google = '$iconPath/google.svg';
  static const String email = '$iconPath/Message.svg';
  static const String phone = '$iconPath/phone.svg';
  static const String marker = '$iconPath/marker.svg';
  static const String locationIcon = '$iconPath/Location.svg';

  //illustration
  static const String success = '$illustrationPath/success.svg';
  static const String opps = '$illustrationPath/opps.svg';
  static const String noNotification = '$illustrationPath/no-notification.svg';
  static const String map = '$illustrationPath/map.svg';
  static const String location = '$illustrationPath/location.svg';
  static const String done = '$illustrationPath/done.svg';
  static const String delete = '$illustrationPath/delete.svg';
}
