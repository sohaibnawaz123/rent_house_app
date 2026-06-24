import 'package:flutter/material.dart';
import 'package:taxi_app/component/image/app_network_image.dart';
import 'package:taxi_app/component/text/content.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/core/utils/extension/app_font_weight.dart';
import 'package:taxi_app/core/utils/extension/app_text_style.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/top_location_entity.dart';

class TopLocationCard extends StatefulWidget {
  final void Function()? onTap;
  final bool isSelected;
  final TopLocationEntity? data;

  const TopLocationCard({
    super.key,
    this.onTap,
    required this.isSelected,
    this.data,
  });

  @override
  State<TopLocationCard> createState() => _TopLocationCardState();
}

class _TopLocationCardState extends State<TopLocationCard> {
  // bool isSelected =
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        // width: 120,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColor.primary : AppColor.lighthighlight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: widget.isSelected ? AppColor.primary : AppColor.baseText,
          ),
        ),
        child: Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: widget.data!.image.isNotEmpty
                  ? AppImage.network(imageUrl: widget.data!.image)
                  : AppImage.asset(assetPath: AppAsset.propertyTwo),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Content(
                data: widget.data?.city ?? 'Malang',
                textStyle: context.bodyText.copyWith(
                  color: widget.isSelected ? AppColor.white : AppColor.baseText,
                  fontWeight: widget.isSelected
                      ? AppFontWeight.semiBold
                      : AppFontWeight.medium,
                ),
                size: 14,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
