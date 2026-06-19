import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taxi_app/component/app_bar/custome_header.dart';
import 'package:taxi_app/component/button/app_button.dart';
import 'package:taxi_app/component/custom_shape/dashborder_widget.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/image_picker/image_picker.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_edge_insets.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_navigation.dart';
import 'package:taxi_app/core/utils/extension/app_sized_box.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/activity/presentation/blocs/bookingreviews/bookingreviews_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/widget/booking_card.dart';

class BookingreviewsView extends StatefulWidget {
  final BookingreviewsBloc bloc;
  const BookingreviewsView({super.key, required this.bloc});

  @override
  State<BookingreviewsView> createState() => _BookingreviewsViewState();
}

class _BookingreviewsViewState extends State<BookingreviewsView> {
  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.base,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          context.pagePadding.top,
          context.pagePadding.right,
          0,
        ),
        children: [
          HeaderWidget(title: 'Write a review'),
          30.heightBox,
          BookingCard(showStatus: false),
          30.heightBox,
          WriteReviewTextArea(controller: reviewController),
          30.heightBox,
          AddPhotoAndVideoSection(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding.left,
          // context.pagePadding.top - 2,0,
          20,
          context.pagePadding.left,
          context.pagePadding.bottom,

          // 0
        ),
        child: AppButton(
          onTap: () => context.popPage(),
          title: 'Submit Review',
        ),
      ),
    );
  }
}

class WriteReviewTextArea extends StatelessWidget {
  final TextEditingController controller;
  const WriteReviewTextArea({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: AppColor.secondaryText,
        strokeWidth: 1.5,
        dashWidth: 6,
        dashSpace: 3,
        radius: 16,
      ),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: TextField(
          controller: controller,
          expands: true,
          maxLines: null,
          minLines: null,
          keyboardType: TextInputType.multiline,
          textAlignVertical: TextAlignVertical.top,
          cursorColor: AppColor.primary,
          style: context.bodyText.copyWith(
            color: AppColor.primaryText,
            height: 1.4,
          ),
          decoration: InputDecoration(
            hintText:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard",
            hintStyle: context.bodyText.copyWith(
              color: AppColor.baseText,
              height: 1.4,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.all(14),
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ),
    );
  }
}

class AddPhotoAndVideoSection extends StatefulWidget {
  const AddPhotoAndVideoSection({super.key});

  @override
  State<AddPhotoAndVideoSection> createState() =>
      _AddPhotoAndVideoSectionState();
}

class _AddPhotoAndVideoSectionState extends State<AddPhotoAndVideoSection> {
  List<File> gallery = [];

  Future<void> _pickGalleryImages() async {
    final pickedImages = await AppImagePicker.pickFiveFromGallery();
    if (!mounted) return;

    setState(() {
      gallery = pickedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Content(
          data: 'Add Photo or Video',
          textStyle: context.headingText.copyWith(color: AppColor.primaryText),
          size: 18,
        ),
        20.heightBox,

        InkWell(
          onTap: _pickGalleryImages,
          child: CustomPaint(
            painter: DashedBorderPainter(
              color: Colors.grey,
              strokeWidth: 1.5,
              dashWidth: 6,
              dashSpace: 3,
              radius: 16,
            ),
            child: Container(
              width: double.infinity,
              height: 150,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppImage.svg(svgPath: AppAsset.upload),
                  10.heightBox,
                  Content(
                    data: 'Click here to upload',
                    textStyle: context.bodyText.copyWith(
                      fontWeight: AppFontWeight.light,
                    ),
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
        gallery.isNotEmpty
            ? GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                itemCount: gallery.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.btnBg,
                        ),
                        child: AppImage.file(
                          filePath: gallery[index].path,
                          size: 74,
                          borderRadius: 10,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              gallery.removeAt(index);
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColor.error,
                            radius: 12,
                            child: Icon(
                              Icons.remove,
                              color: AppColor.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
