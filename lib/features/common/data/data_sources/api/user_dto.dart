import 'package:flutter/foundation.dart';
import 'package:github_search/features/common/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final int id;
  
  final String login;

  @JsonKey(name: "avatar_url")
  final String avatarUrl;
  
  @JsonKey(name: "html_url")
  final String htmlUrl;

  final String type;

  UserDto({
    @required this.id,
    @required this.login,
    @required this.avatarUrl,
    @required this.htmlUrl,
    @required this.type,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserModel toModel() {
    return UserModel(
      id: id,
      login: login,
      avatarUrl: avatarUrl,
      htmlUrl: htmlUrl,
      type: type,
    );
  }
}
