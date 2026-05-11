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
  static const String onboarding1 = '$iconPath/onboarding_one.svg';
  static const String onboarding2 = '$iconPath/onboarding_two.svg';
  static const String onboarding3 = '$iconPath/onboarding_three.svg';

  //icons
  static const String eye = '$iconPath/eye.svg';
  static const String eyeoff = '$iconPath/eye-off.svg';
  static const String back = '$iconPath/back.svg';
  static const String info = '$iconPath/Paper.svg';
}
