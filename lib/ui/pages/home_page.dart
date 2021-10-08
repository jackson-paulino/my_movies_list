import 'package:flutter/material.dart';
import 'package:my_movies_list/data/repositories/user_repository_interface.dart';
import 'package:my_movies_list/ui/shared/app_locator.dart';
import 'package:my_movies_list/ui/shared/app_routes.dart';

import 'tabs_pages/main_tab_page.dart';
import 'tabs_pages/movies_tab_page.dart';
import 'tabs_pages/series_tab_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Catálogo'),
            bottom: const TabBar(
              tabs: [
                Tab(child: Text('Principal')),
                Tab(child: Text('Filmes')),
                Tab(child: Text('Seŕies'))
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.usersPage),
                  icon: const Icon(Icons.account_circle_outlined)),
              IconButton(
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.ratingTitlePage,
                      arguments: null),
                  icon: const Icon(Icons.thumbs_up_down_outlined)),
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.searchPage),
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () async {
                    await getIt.get<UserRepositoryInferface>().clearSession();
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.loginPage, (route) => false);
                  },
                  icon: const Icon(Icons.exit_to_app))
            ],
          ),
          body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [MainTabPage(), MoviesTabPage(), SeriesTabPage()]),
        ));
  }
}
