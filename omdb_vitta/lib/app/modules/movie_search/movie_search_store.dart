import 'package:mobx/mobx.dart';

import '../../shared/models/movie_model.dart';
import '../../shared/stores/search_store.dart';

part 'movie_search_store.g.dart';

class MovieSearchStore = _MovieSearchStoreBase with _$MovieSearchStore;

abstract class _MovieSearchStoreBase with Store {
  final SearchStore searchStore;

  _MovieSearchStoreBase(this.searchStore);
  @observable
  bool enableSearch = true;
  @action
  toggleSearch() => enableSearch = !enableSearch;

  @observable
  ObservableList<MovieModel> moviesList = ObservableList<MovieModel>();

  @observable
  int currentPageIndex = 0;
  @action
  setCurrentPageIndex(int index) => currentPageIndex = index;

  @observable
  int maxSearchItems = 0;
  @action
  setMaxSearchItems(int newValue) => maxSearchItems = newValue;

  @computed
  bool get showRigthArrow =>
      (moviesList.isNotEmpty && moviesList.length > 1 && currentPageIndex != moviesList.length - 1) ? true : false;

  @computed
  bool get showLeftArrow => (moviesList.isNotEmpty && moviesList.length > 1 && currentPageIndex != 0) ? true : false;

  @observable
  MovieModel movieOnScreen = MovieModel();
  @action
  setMovieOnScreen(MovieModel movie) => movieOnScreen = movie;

  @observable
  MovieModel selectedMovie;
  @action
  setSelectedMovie(MovieModel movie) => selectedMovie = movie;
}
