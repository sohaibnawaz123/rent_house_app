import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        shrinkWrap: true,
        itemCount: entity.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => handleShare(entity[index].name),
            child: ShareIconCard(entity: entity[index]),
          );
        },
      ),
    );
  }

  void handleShare(String title) {
    if (title.toLowerCase() == "whatsapp") {
      Share.share(
        "🏡 House of Mormon\n"
        "💰 \$310/month\n\n"
        "Check out this property:\n",
      );
    }
    if (title.toLowerCase() == "linkedin") {
      Share.share(
        "🏡 House of Mormon\n"
        "💰 \$310/month\n\n"
        "Check out this property:\n",
      );
    }
    if (title.toLowerCase() == "pinterest") {
      Share.share(
        "🏡 House of Mormon\n"
        "💰 \$310/month\n\n"
        "Check out this property:\n",
      );
    }
    if (title.toLowerCase() == "twitter") {
      Share.share(
        "🏡 House of Mormon\n"
        "💰 \$310/month\n\n"
        "Check out this property:\n",
      );
    }
    if (title.toLowerCase() == "instagram") {
      Share.share(
        "🏡 House of Mormon\n"
        "💰 \$310/month\n\n"
        "Check out this property:\n",
      );
    }
  }
}
