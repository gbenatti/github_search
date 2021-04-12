
import 'package:github_search/features/common/data/models/user_model.dart';

abstract class FavoriteLocalDataSource {
  Future<List<UserModel>> loadFavorites();
  Future<List<UserModel>> addFavorite(UserModel user);
  Future<List<UserModel>> removeFavorite(UserModel user);
}
