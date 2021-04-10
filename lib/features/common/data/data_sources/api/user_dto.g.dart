// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return UserDto(
    id: json['id'] as int,
    login: json['login'] as String,
    avatarUrl: json['avatar_url'] as String,
    htmlUrl: json['html_url'] as String,
    type: json['type'] as String,
    name: json['name'] as String,
    company: json['company'] as String,
    location: json['location'] as String,
    bio: json['bio'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'html_url': instance.htmlUrl,
      'type': instance.type,
      'name': instance.name,
      'company': instance.company,
      'location': instance.location,
      'bio': instance.bio,
      'email': instance.email,
    };
