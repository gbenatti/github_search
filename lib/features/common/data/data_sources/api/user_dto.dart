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

  final String name;
  final String company;
  final String location;
  final String bio;
  final String email;

  UserDto({
    @required this.id,
    @required this.login,
    @required this.avatarUrl,
    @required this.htmlUrl,
    @required this.type,
    this.name,
    this.company,
    this.location,
    this.bio,
    this.email,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  factory UserDto.fromModel(UserModel model) {
    return UserDto(
      id: model.id,
      login: model.login,
      avatarUrl: model.avatarUrl,
      htmlUrl: model.htmlUrl,
      type: model.type,
      name: model.name,
      company: model.company,
      location: model.location,
      bio: model.bio,
      email: model.email,
    );
  }

  UserModel toModel() {
    return UserModel(
      id: id,
      login: login,
      avatarUrl: avatarUrl,
      htmlUrl: htmlUrl,
      type: type,
      name: name,
      company: company,
      location: location,
      bio: bio,
      email: email,
    );
  }
}
