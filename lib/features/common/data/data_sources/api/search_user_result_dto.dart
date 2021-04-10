import 'package:github_search/features/common/data/data_sources/api/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_user_result_dto.g.dart';

@JsonSerializable()
class SearchUserResultDto {
  @JsonKey(name: "total_count")
  final int totalCount;

  @JsonKey(name: "imcomplete_results")
  final bool incompleteResults;

  final List<UserDto> items;

  SearchUserResultDto({this.totalCount, this.incompleteResults, this.items});

  factory SearchUserResultDto.fromJson(Map<String, dynamic> json) => _$SearchUserResultDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchUserResultDtoToJson(this);
}
