import 'package:github_search/features/user_search/data/data_sources/api/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_user_result_dto.g.dart';

@JsonSerializable()
class SearchUserResultDto {
  final List<UserDto> results;

  SearchUserResultDto({this.results});

  factory SearchUserResultDto.fromJson(Map<String, dynamic> json) => _$SearchUserResultDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchUserResultDtoToJson(this);
}
