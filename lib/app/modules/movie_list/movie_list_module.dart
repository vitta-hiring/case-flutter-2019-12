import 'package:vitta_test/app/modules/movie_list/movie_list_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:vitta_test/app/modules/movie_list/movie_list_page.dart';
import 'package:vitta_test/app/modules/movie_list/omdb_service.dart';

class MovieListModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => MovieListBloc()),
      ];

  @override
  List<Dependency> get dependencies => [Dependency((i) => OMDBService())];

  @override
  Widget get view => MovieListPage();

  static Inject get to => Inject<MovieListModule>.of();
}
