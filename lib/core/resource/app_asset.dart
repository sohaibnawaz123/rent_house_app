class AppAsset {
  AppAsset._internal();
  static final AppAsset _instance = AppAsset._internal();

  factory AppAsset() {
    return _instance;
  }
  static const String iconPath = 'assets/icons/';
  static const String imagePath = 'assets/images/';
  static const String illustrationPath = 'assets/illustration/';
 static const String lottiePath = 'assets/lottie/';

  static const String applogo = '$imagePath/logo-icon.png';

  //icons
  static const String eye = '$iconPath/eye.svg';
  static const String eyeoff = '$iconPath/eye-off.svg';
  static const String back = '$iconPath/back.svg';
  
}
