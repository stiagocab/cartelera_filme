import 'package:filme/src/models/movie_model.dart';
import 'package:filme/src/search/search_delegate.dart';
import 'package:filme/src/widgets/card_slider_widget.dart';
import 'package:filme/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';
import 'package:filme/src/providers/movies_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final moviesList = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesList.getPopularMovies();
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Cartelera"), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: SearchData());
          },
        )
      ]),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swipedCards(_screenSize), // horizontal slider
              _footer(context, _screenSize)
            ],
          ),
        ),
      ),
    );
  }

  // create the horizontal slider to films
  Widget _swipedCards(_screenSize) {
    return FutureBuilder(
      future: moviesList.getPlayingNow(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        // return Center(child: CircularProgressIndicator());
        if (snapshot.hasData) {
          return CardSwiper(cardList: snapshot.data);
        } else {
          return Container(
            height: _screenSize.width * 0.5,
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context, _screenSize) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Popular",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          SizedBox(height: 15.0),
          StreamBuilder(
            stream: moviesList.popularStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.hasData) {
                return MovieSlider(
                    moviesList: snapshot.data,
                    nextPage: moviesList.getPopularMovies);
              }
              return Container(
                height: _screenSize.width * 0.3,
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
