
import 'package:github_search/features/common/data/models/favorite_model.dart';

abstract class FavoriteLocalDataSource {
    Future<List<FavoriteModel>> loadFavorites();
}