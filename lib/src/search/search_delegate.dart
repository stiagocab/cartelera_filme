// import 'package:filme/src/models/movie_model.dart';
import 'package:filme/src/models/movie_model.dart';
import 'package:filme/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class SearchData extends SearchDelegate {
  final moviesProvider = MoviesProvider();

  final movieSugestions = [
    "Spiderman",
    "Scooby!",
    "El stand de los besos",
    "La vieja guardia"
  ];

  final moviesList = [
    "Pelicula 1",
    "Pelicula 2",
    "Pelicula 3",
    "Pelicula 4",
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: theme.primaryColorBrightness,
      primaryTextTheme: theme.primaryTextTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TO DO: implement buildActions
    // throw UnimplementedError();
    return [
      IconButton(
          icon: AnimatedIcon(
            progress: transitionAnimation,
            icon: AnimatedIcons.menu_close,
          ),
          onPressed: () => query = "")
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TO DO: implement buildLeading
    // throw UnimplementedError();
    return IconButton(
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TO DO: implement buildResults
    // throw UnimplementedError();
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TO DO: implement buildSuggestions

    if (query.length < 3) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView.builder(
            itemCount: peliculas.length,
            itemBuilder: (BuildContext context, i) {
              return _tileMovie(peliculas[i], context);
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _tileMovie(Movie pelicula, BuildContext context) {
    pelicula.uniqueId = '${pelicula.id}-tile-search';
    return GestureDetector(
      onTap: () {
        close(context, null);
        Navigator.pushNamed(context, "detail", arguments: pelicula);
      },
      child: ListTile(
        leading: Hero(
          tag: pelicula.uniqueId,
          child: FadeInImage(
            width: 50.0,
            fit: BoxFit.cover,
            placeholder: AssetImage("assets/img/no-image.jpg"),
            image: NetworkImage(
              pelicula.getPosterImg(),
            ),
          ),
        ),
        title: Text(
          pelicula.title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(pelicula.originalTitle),
      ),
    );
  }

  /* List<Widget> _renderMovies(movies) {
    return movies.map<Widget>((pelicula) {
      return _renderMoviee(Movie pelicula);
    }).toList();
  } */
}
