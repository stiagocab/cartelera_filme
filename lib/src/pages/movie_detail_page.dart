import 'package:filme/src/models/actors_model.dart';
import 'package:filme/src/models/movie_model.dart';
import 'package:filme/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class MovieDetailsPage extends StatelessWidget {
  // final Movie movie;
  MovieDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _renderAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _posterTitle(movie, context),
              _descriptionMovie(movie, context),
              _casting(movie)
            ]),
          ),
        ],
      ),
    );
  }

  Widget _renderAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white60,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          textAlign: TextAlign.center,
        ),
        background: FadeInImage(
          placeholder: AssetImage("assets/img/loading.gif"),
          image: NetworkImage(
            movie.getBackgroundPath(),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                height: 200.0,
                image: NetworkImage(movie.getPosterImg()),
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /*  Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline3,
                  overflow: TextOverflow.ellipsis,
                ), */
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border, color: Colors.amber),
                    Text(
                      movie.voteAverage.toString(),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionMovie(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
      child: Text(
        movie.overview,
        style: TextStyle(fontSize: 17.0, height: 1.4),
      ),
    );
  }

  Widget _casting(
    Movie movie,
  ) {
    final peliProvider = MoviesProvider();
    return FutureBuilder(
      future: peliProvider.getCast(movie.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _castingPageView(snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _castingPageView(List<Actor> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 15.0),
          child: Text(
            "Cast",
            style: TextStyle(fontSize: 22.0, color: Colors.blueGrey),
          ),
        ),
        SizedBox(
          height: 200.0,
          child: PageView.builder(
            pageSnapping: false,
            itemCount: data.length,
            controller: PageController(initialPage: 1, viewportFraction: 0.26),
            itemBuilder: (context, i) => _actorCard(data[i]),
          ),
        ),
      ],
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              width: 90.0,
              height: 120.0,
              fit: BoxFit.cover,
              placeholder: AssetImage("assets/img/no-image.jpg"),
              image: NetworkImage(
                actor.getPhoto(),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            actor.name,
            style: TextStyle(
              color: Colors.blueGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
