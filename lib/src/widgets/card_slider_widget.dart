import 'package:flutter/material.dart';
import 'package:filme/src/models/movie_model.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> moviesList;
  final Function nextPage; // function to call when I'm going to finish the list
  final _pageController =
      PageController(initialPage: 2, viewportFraction: 0.35);

  MovieSlider({Key key, @required this.moviesList, @required this.nextPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      var willEnd = _pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 250;
      if (willEnd) {
        // if the scroll is going to reach the end call the next page
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      padding: EdgeInsets.only(left: 10.0),
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: moviesList.length,
        // render card movie
        itemBuilder: (context, i) => _card(context, moviesList[i], _screenSize),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie, screenSize) {
    final titleMovie = Container(
      // name/title  to render in a column
      padding: EdgeInsets.only(
        left: 5.0,
        top: 10.0,
        right: 5.0,
      ),
      child: Text(
        movie.title,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );

    final dataMovie = Padding(
      // general info about curren movie
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            // rate movie
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.grey,
                size: 18,
              ),
              Text(
                "${movie.voteAverage}",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          Text(
            // release year movie
            "${movie.getFullYear()}", // method to get the full year from releaseDate
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );

    final movieCard = Container(
      width: 100.0,
      child: Column(children: <Widget>[
        Padding(
          // image movie
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              height: screenSize.height * 0.21,
              // width: screenSize.width * 0.27,
              fit: BoxFit.cover,
              image: NetworkImage(movie.getPosterImg()),
              placeholder: AssetImage("assets/img/no-image.jpg"),
            ),
          ),
        ),
        titleMovie,
        dataMovie,
      ]),
    );

    return GestureDetector(
      child: movieCard,
      onTap: () {
        Navigator.pushNamed(context, "detail", arguments: movie);
      },
    );
  }

  /* 
  // render cards as List<Widget>
    List<Widget> _cards(BuildContext context, screenSize) {
      return moviesList.map((movie) {
        return _card(context, movie, screenSize);
      }).toList();
    }
  */
}
