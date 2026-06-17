import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_asset.dart';
import 'package:taxi_app/modules/activity/presentation/widget/share_icon_card.dart';

class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ShareIconCardEntity> entity = [
      ShareIconCardEntity(name: 'Facebook', iconName: AppAsset.facebook),
      ShareIconCardEntity(name: 'Instagram', iconName: AppAsset.instagram),
      ShareIconCardEntity(name: 'WhatsApp', iconName: AppAsset.whatsapp),
      ShareIconCardEntity(name: 'Twitter', iconName: AppAsset.twitter),
      ShareIconCardEntity(name: 'Linkedin', iconName: AppAsset.linkedin),
      ShareIconCardEntity(name: 'Pinterest', iconName: AppAsset.pinterest),
    ];
    return SizedBox(
      height: 250,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        shrinkWrap: true,
        itemCount: entity.length,
        itemBuilder: (context, index) {
          return ShareIconCard(entity: entity[index]);
        },
      ),
    );
  }
}
