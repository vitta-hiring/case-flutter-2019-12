import 'package:flutter/material.dart';
import 'package:vitta_test/app/models/movie_model.dart';
import 'package:vitta_test/app/modules/movie_details/movie_details_module.dart';
import 'package:vitta_test/app/modules/movie_list/movie_list_bloc.dart';
import 'package:vitta_test/app/modules/movie_list/movie_list_module.dart';

const title = "FILMES";

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final MovieListBloc _movieListBloc =
      MovieListModule.to.getBloc<MovieListBloc>();
  Future<List<MovieModel>> _movies;

  final TextEditingController _searchController =
      TextEditingController(text: "");
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    this._movies = this._movieListBloc.getMovies('rambo');
    super.initState();
  }

  Widget _buildListOfMovies(List<MovieModel> movies) {
    if (movies.isEmpty)
      return Center(
        child:
            Text('Não encontramos nada com \'${this._searchController.text}\''),
      );
    return GridView.builder(
      itemCount: movies.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) =>
          this._buildMovieGridTile(movies[index]),
    );
  }

  Widget _getErrorIcon(String movieTitle) => Container(
        color: Colors.black26,
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          movieTitle,
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  Widget _buildMovieGridTile(MovieModel movie) => GridTile(
        child: InkWell(
          enableFeedback: true,
          child: Hero(
            tag: movie.imdbID,
            child: Image.network(
              movie.poster,
              fit: BoxFit.cover,
              errorBuilder: (_, obj, stack) => this._getErrorIcon(movie.title),
            ),
          ),
          onTap: () => this._goToMovieDetails(movie),
        ),
      );

  _searchMovie() {
    if (this._searchController.text.isNotEmpty)
      this._movies = this._movieListBloc.getMovies(this._searchController.text);
    setState(() {});
  }

  Widget _getSearchTextInput() => Container(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: this._searchController,
          focusNode: this._searchFocus,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          onEditingComplete: this._searchMovie,
          cursorColor: Colors.white,
          decoration: InputDecoration.collapsed(
            hintText: 'Pesquisar...',

            // contentPadding: EdgeInsets.symmetric(vertical: 5),
            // contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusColor: Colors.white,
            fillColor: Colors.white,
            hoverColor: Colors.white,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(15),
            // ),
            // suffix: IconButton(
            //   icon: Icon(
            //     Icons.search,
            //     size: 20,
            //   ),
            //   onPressed: _searchMovie,
            // ),
          ),
        ),
      );

  _goToMovieDetails(MovieModel movie) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieDetailsModule(
              movie, this._movieListBloc.getMoviesByImdbID(movie.imdbID)),
          fullscreenDialog: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          this._getSearchTextInput(),
          Expanded(
            child: FutureBuilder<List<MovieModel>>(
                initialData: [],
                future: this._movies,
                builder: (_, AsyncSnapshot<List<MovieModel>> snap) {
                  if (snap.hasData) {
                    return this._buildListOfMovies(snap.data);
                  } else if (snap.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container();
                }),
          )
        ],
      ),
    );
  }
}
