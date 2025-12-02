import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dates.g.dart';

@JsonSerializable()
class Dates extends Equatable {
  final String maximum;
  final String minimum;

  const Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) =>
      _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);

  @override
  List<Object?> get props => [maximum, minimum];
}