import 'package:filme/src/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> cardList; // list to render on Swiper
  CardSwiper({Key key, @required this.cardList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(20.0),
      // height: _screenSize.height * 0.5,
      child: Swiper(
        itemWidth: _screenSize.width * 0.55,
        itemHeight: _screenSize.height * 0.4,
        itemBuilder: (BuildContext context, int index) {
          cardList[index].uniqueId = '${cardList[index].id}-card-slide';
          return _imageSlide(cardList[index], context);
        },
        itemCount: cardList.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }

  Widget _imageSlide(
    Movie movie,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "detail", arguments: movie);
      },
      child: Hero(
        tag: movie.uniqueId,
        child: ClipRRect(
          // image slide
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            // fadeInDuration: Duration(milliseconds: 200),
            fadeOutDuration: Duration(milliseconds: 300),
            fadeOutCurve: Curves.linear,
            placeholder: AssetImage("assets/img/no-image.jpg"),
            image: NetworkImage(
              movie.getPosterImg(),
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
