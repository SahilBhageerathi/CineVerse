import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dates.dart';
import 'movie.dart';

part 'now_playing_response.g.dart';

@JsonSerializable()
class NowPlayingResponse extends Equatable {
  final Dates? dates;
  final int page;

  @JsonKey(name: "total_pages")
  final int totalPages;

  @JsonKey(name: "total_results")
  final int totalResults;

  final List<Movie> results;

  const NowPlayingResponse({
    this.dates,
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory NowPlayingResponse.fromJson(Map<String, dynamic> json) =>
      _$NowPlayingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NowPlayingResponseToJson(this);

  @override
  List<Object?> get props => [dates, page, totalPages, totalResults, results];
}
