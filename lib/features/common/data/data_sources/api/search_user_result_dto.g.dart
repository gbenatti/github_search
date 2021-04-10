// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUserResultDto _$SearchUserResultDtoFromJson(Map<String, dynamic> json) {
  return SearchUserResultDto(
    totalCount: json['total_count'] as int,
    incompleteResults: json['imcomplete_results'] as bool,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : UserDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchUserResultDtoToJson(
        SearchUserResultDto instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'imcomplete_results': instance.incompleteResults,
      'items': instance.items,
    };
