// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUserResultDto _$SearchUserResultDtoFromJson(Map<String, dynamic> json) {
  return SearchUserResultDto(
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : UserDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchUserResultDtoToJson(
        SearchUserResultDto instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
