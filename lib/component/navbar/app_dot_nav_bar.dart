// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:taxi_app/core/resource/app_color.dart';
// import 'package:taxi_app/features/root/presentation/bloc/root_bloc.dart';


// class AppDotNavBar extends StatelessWidget {
//   final RootBloc bloc;
//   const AppDotNavBar({super.key, required this.bloc});

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

//         // height: 80,
//         color: AppColor.white,
//         child: BlocBuilder<RootBloc, RootState>(
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

// class _CustomNavbarIcons extends StatelessWidget {
//   final String icon;
//   final bool isSelected;

//   const _CustomNavbarIcons({required this.icon, required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 600),
//       curve: Curves.easeOut,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AnimatedSlide(
//             duration: const Duration(milliseconds: 600),
//             curve: Curves.easeOut,
//             offset: isSelected ? const Offset(0, -0.2) : Offset.zero,
//             child: SvgPicture.asset(
//               icon,
//               color: isSelected ? AppColor.primary : AppColor.black,
//             ),
//           ),
//           AnimatedOpacity(
//             duration: const Duration(milliseconds: 600),
//             opacity: isSelected ? 1.0 : 0.0,
//             child: isSelected
//                 ? Container(
//                     width: 6,
//                     height: 6,
//                     decoration: const BoxDecoration(
//                       color: AppColor.primary,
//                       shape: BoxShape.circle,
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ),
//         ],
//       ),
//     );
//   }
// }
