// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gif/gif.dart';
// import 'package:taxi_app/features/dashboard/dashboard/bloc/dashboard_bloc.dart';
// import 'package:taxi_app/features/dashboard/dashboard/constant.dart';
// import 'package:taxi_app/resource/app_asset.dart';
// import 'package:taxi_app/core/resource/app_color.dart';


// class AppAnimatedNavBar extends StatelessWidget {
//   final DashboardBloc bloc;
//   const AppAnimatedNavBar({super.key, required this.bloc});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.hardEdge,
//       decoration: BoxDecoration(
//         color: AppColor.white,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),

//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withValues(alpha: 0.6),
//             blurRadius: 4,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       child: BottomAppBar(
//         padding: EdgeInsets.zero,

//         color: AppColor.white,
//         child: BlocBuilder<DashboardBloc, DashboardState>(
//           bloc: bloc,
//           builder: (context, asyncSnapshot) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(navBarItems.length, (index) {
//                 final interation = navBarItems[index];
//                 return GestureDetector(
//                   onTap: () {
//                     bloc.add(OnPageChangeEvent(index));
//                   },
//                   child: _CustomNavbarIcons(
//                     icon: interation.icon,
//                     isSelected: index == bloc.state.currentIndex,
//                   ),
//                 );
//               }),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class _CustomNavbarIcons extends StatefulWidget {
//   final String icon;
//   final bool isSelected;
//   const _CustomNavbarIcons({
//     super.key,
//     required this.icon,
//     required this.isSelected,
//   });

//   @override
//   State<_CustomNavbarIcons> createState() => __CustomNavbarIconsState();
// }

// // class __CustomNavbarIconsState extends State<_CustomNavbarIcons> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //   }
// // }
// class __CustomNavbarIconsState extends State<_CustomNavbarIcons>
//     with TickerProviderStateMixin {
//   late GifController _gifController;
//   bool _hasPlayed = false;

//   //   @override
//   //   void initState() {
//   //     super.initState();
//   //  final gifDuration = Duration(milliseconds: 1000);

//   //     _gifController = GifController(vsync: this, duration: gifDuration);
//   //     // Delay playback until after first frame is rendered
//   //     WidgetsBinding.instance.addPostFrameCallback((_) {
//   //       if (widget.isSelected && !_hasPlayed) {
//   //         _gifController.reset();
//   //         _gifController.forward();
//   //         _hasPlayed = true;
//   //       }
//   //     });
//   //   }

//   @override
//   void initState() {
//     super.initState();

//     // Set a duration based on the number of frames and fps
//     // For example, if your GIF has 30 frames and you want 30 fps:

//     _gifController = GifController(vsync: this);
//     // // Precache image to avoid flicker
//     // precacheImage(AssetImage(widget.icon), context);

//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   if (widget.isSelected && !_hasPlayed) {
//     //     _gifController.reset();
//     //     _gifController.forward();
//     //     _hasPlayed = true;
//     //   }
//     // });
//   }

//   @override
//   void didUpdateWidget(covariant _CustomNavbarIcons oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     // Play GIF only when selected changes from false to true
//     if (!oldWidget.isSelected && widget.isSelected) {
//       _gifController.reset();
//       _gifController.forward();
//       _hasPlayed = true;
//     }
//   }

//   @override
//   void dispose() {
//     _gifController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Gif(
//       // duration: const Duration(milliseconds: 1000),
//       controller: _gifController,
//       fit: BoxFit.fitHeight,
//       height:
//           (widget.icon == AppAsset.homeAnimation ||
//               widget.icon == AppAsset.walletAnimation)
//           ? 33.h
//           : 37.h,
//       image: AssetImage(widget.icon),
//       color: widget.isSelected
//           ? AppColor.primary
//           : AppColor.black.withValues(alpha: 0.7),
//       autostart: Autostart.no,
//       // fps: 30,
//     );
//   }
// }

// // class _CustomNavbarIcons extends StatelessWidget {
// //   final String icon;
// //   final bool isSelected;

// //   const _CustomNavbarIcons({required this.icon, required this.isSelected});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Gif(
// //       fit: BoxFit.fitHeight,
// //       height:
// //           (icon == AppAsset.homeAnimation || icon == AppAsset.walletAnimation)
// //           ? 33.h
// //           : 37.h,

// //       // width: 36.h,
// //       autostart: Autostart.once,
// //       image: AssetImage(icon),
// //       color: isSelected
// //           ? AppColor.primary
// //           : AppColor.black.withValues(alpha: 0.7),
// //     );
// //   }
// // }
