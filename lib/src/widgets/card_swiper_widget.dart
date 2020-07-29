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
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              // fadeInDuration: Duration(milliseconds: 200),
              fadeOutDuration: Duration(milliseconds: 300),
              fadeOutCurve: Curves.linear,
              placeholder: AssetImage("assets/img/no-image.jpg"),
              image: NetworkImage(
                cardList[index].getPosterImg(),
              ),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: cardList.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
