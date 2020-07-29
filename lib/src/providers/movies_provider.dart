import 'package:filme/src/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MoviesProvider {
  String _apiKey = "8046b799a352e750028ad9d65d1683e3";
  String _url = "api.themoviedb.org";
  String _language = "es-MX";
  int _popularsPage = 0;
  bool _popularsLoading = false;

  List<Movie> _populars = List();
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;
  Stream<List<Movie>> get popularStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _getResponse(String ednPoint) async {
    final url =
        Uri.https(_url, ednPoint, {'api_key': _apiKey, 'language': _language});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJsonList(decodedData["results"]);
    return movies.items;
  }

  Future<List<Movie>> _getCustomResponse(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJsonList(decodedData["results"]);
    return movies.items;
  }

  Future<List<Movie>> getPlayingNow() async {
    return await _getResponse("3/movie/now_playing");
  }

  Future<List<Movie>> getPopularMovies() async {
    if (_popularsLoading) return [];
    _popularsLoading = true;
    _popularsPage++;
    final url = Uri.https(_url, "3/movie/popular", {
      'api_key': _apiKey,
      'language': _language,
      "page": _popularsPage.toString()
    });

    final resp = await _getCustomResponse(url);
    _populars.addAll(resp);
    popularsSink(_populars);
    _popularsLoading = false;
    return resp;
  }
}
