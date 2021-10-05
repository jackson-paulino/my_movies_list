import 'package:get_it/get_it.dart';
import 'package:my_movies_list/data/repositories/title_repository.dart';
import 'package:my_movies_list/data/repositories/title_repository_interface.dart';
import 'package:my_movies_list/data/services/http_service.dart';

var getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerLazySingleton(() => HttpService());
  getIt.registerLazySingleton<TitleRepositoryInterface>(
      () => TitleRepository(getIt.get<HttpService>()));
}
