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
  static const String building = '$imagePath/building.png';
  static const String propertyOne = '$imagePath/property1.png';
  static const String propertyTwo = '$imagePath/property2.png';
  // static const String fillHeart = '$imagePath/Heart.png';

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
  static const String notification = '$iconPath/Notification.svg';
  static const String chat = '$iconPath/Chat.svg';
  static const String filter = '$iconPath/Filter.svg';
  static const String search = '$iconPath/Search.svg';
  static const String fillHeart = '$iconPath/fillHeart.svg';
  static const String reviews = '$iconPath/review.svg';
  static const String camera = '$iconPath/Camera.svg';
  static const String about = '$iconPath/info-square.svg';
  static const String setting = '$iconPath/Setting.svg';
  static const String wallet = '$iconPath/Wallet.svg';
  static const String recentView = '$iconPath/time-square.svg';
  static const String logout = '$iconPath/logout.svg';
  static const String clander = '$iconPath/calendar.svg';
  static const String share = '$iconPath/share.svg';
  static const String forward = '$iconPath/forward.svg';
  static const String area = '$iconPath/area.svg';
  static const String bath = '$iconPath/bath.svg';
  static const String bed = '$iconPath/bed.svg';
  static const String facebook = '$iconPath/facebook.svg';
  static const String instagram = '$iconPath/insta.svg';
  static const String linkedin = '$iconPath/linkedin.svg';
  static const String pinterest = '$iconPath/pintrest.svg';
  static const String twitter = '$iconPath/twitter.svg';
  static const String whatsapp = '$iconPath/whatapp.svg';

  //illustration
  static const String success = '$illustrationPath/success.svg';
  static const String opps = '$illustrationPath/opps.svg';
  static const String noNotification = '$illustrationPath/no-notification.svg';
  static const String map = '$illustrationPath/map.svg';
  static const String location = '$illustrationPath/location.svg';
  static const String done = '$illustrationPath/done.svg';
  static const String delete = '$illustrationPath/delete.svg';

  // dashboard icons
  static const String home = '$iconPath/home.svg';
  static const String explore = '$iconPath/explore.svg';
  static const String favourite = '$iconPath/favourite.svg';
  static const String booking = '$iconPath/booking.svg';
  static const String profile = '$iconPath/Profile.svg';
  // dashboard activeicons
  static const String homeActive = '$iconPath/home_active.svg';
  static const String exploreActive = '$iconPath/explore_active.svg';
  static const String favouriteActive = '$iconPath/favourite_active.svg';
  static const String bookingActive = '$iconPath/booking_active.svg';
  static const String profileActive = '$iconPath/profile_active.svg';

}
