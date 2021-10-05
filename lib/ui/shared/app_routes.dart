import 'package:flutter/material.dart';
import 'package:my_movies_list/ui/pages/home_page.dart';
import 'package:my_movies_list/ui/pages/login_page.dart';
import 'package:my_movies_list/ui/pages/rating_title_page.dart';
import 'package:my_movies_list/ui/pages/register_user_page.dart';
import 'package:my_movies_list/ui/pages/search_page.dart';
import 'package:my_movies_list/ui/pages/title_details_page.dart';
import 'package:my_movies_list/ui/pages/users_page.dart';

class AppRoutes {
  static const loginPage = 'login-page';
  static const homePage = 'home-page';
  static const searchPage = 'search-page';
  static const titleDetailsPage = 'title-details-page';
  static const registerUserPage = 'register-user-page';
  static const ratingTitlePage = 'rating-title-page';
  static const usersPage = 'users_page';
  
}

Map<String, Widget Function(BuildContext)> routes = {
  'login-page': (_) => LoginPage(),
  'home-page': (_) => const HomePage(),
  'search-page': (_) => const SearchPage(),
  'title-details-page': (_) => TitleDetailsPage(),
  'register-user-page': (_) => const RegisterUserPage(),
  'rating-title-page': (_) => const RatingTitlePage(),
  'users_page': (_) => const UsersPage()
};
