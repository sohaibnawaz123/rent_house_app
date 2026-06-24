import 'package:equatable/equatable.dart';
import 'package:taxi_app/modules/dashboard/domain/entities/dashboardhome_entities/top_location_entity.dart';

class TopLocationModel extends Equatable {
  final String? city;
  final String? state;
  final String? country;
  final String? image;
  final int? propertiesCount;

  const TopLocationModel({
    this.city,
    this.state,
    this.country,
    this.image,
    this.propertiesCount,
  });

  factory TopLocationModel.fromJson(Map<String, dynamic> json) {
    return TopLocationModel(
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      image: json['image'] as String?,
      propertiesCount: json['properties_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'state': state,
      'country': country,
      'image': image,
      'properties_count': propertiesCount,
    };
  }

  TopLocationModel copyWith({
    String? city,
    String? state,
    String? country,
    String? image,
    int? propertiesCount,
  }) {
    return TopLocationModel(
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      image: image ?? this.image,
      propertiesCount: propertiesCount ?? this.propertiesCount,
    );
  }

  TopLocationEntity toEntity() {
    return TopLocationEntity(
      city: city ?? '',
      state: state ?? '',
      country: country ?? '',
      image: image ?? '',
      propertiesCount: propertiesCount ?? 0,
    );
  }

  @override
  List<Object?> get props => [city, state, country, image, propertiesCount];
}
