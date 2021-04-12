import 'dart:convert';
import 'dart:io';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/features/common/data/data_sources/api/user_dto.dart';
import 'package:github_search/features/common/data/models/user_model.dart';
import 'package:path/path.dart' as p;
import 'package:github_search/features/common/data/data_sources/favorite_local_data_source.dart';
import 'package:path_provider/path_provider.dart';

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  @override
  Future<List<UserModel>> loadFavorites() async {
    try {
      String jsonString = await _loadJson();
      final favorites = _parseFavorites(jsonString);
      return favorites.map((fav) => fav.toModel());
    } on Exception {
      throw LoadException();
    }
  }

  Future<String> _loadJson() async {
    final filePath = await _getFavoritesFilePath();
    final jsonString = await File(filePath).readAsString();
    return jsonString;
  }

  Iterable<UserDto> _parseFavorites(String jsonString) {
    List<Map<String, dynamic>> parsed =
        jsonDecode(jsonString).cast<List<Map<String, dynamic>>>();
    return parsed.map((jsonMap) => UserDto.fromJson(jsonMap)).toList();
  }

  @override
  Future<List<UserModel>> addFavorite(UserModel user) {
    throw UpdateFavoriteException();
  }

  @override
  Future<List<UserModel>> removeFavorite(UserModel user) {
    throw UpdateFavoriteException();
  }

  Future<void> _saveFavorites(List<UserModel> favorites) async {
    final models = favorites.map((model) => UserDto.fromModel(model));
    final jsonString = _serializeFavorites(models);
    await _saveJson(jsonString);
  }

  Future<void> _saveJson(String jsonString) async {
    final filePath = await _getFavoritesFilePath();
    await File(filePath).writeAsString(jsonString);
  }

  String _serializeFavorites(List<UserDto> favorites) {
    return jsonEncode(favorites);
  }

  Future<String> _getFavoritesFilePath() async {
    final docDir = await getApplicationDocumentsDirectory();
    return p.join(docDir.path, "favorites.json");
  }
}
