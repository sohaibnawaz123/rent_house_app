import 'package:equatable/equatable.dart';

class TopLocationEntity extends Equatable {
  final String city;
  final String state;
  final String country;
  final String image;
  final int propertiesCount;

  const TopLocationEntity({
    required this.city,
    required this.state,
    required this.country,
    required this.image,
    required this.propertiesCount,
  });

  @override
  List<Object?> get props => [city, state, country, image, propertiesCount];
}
