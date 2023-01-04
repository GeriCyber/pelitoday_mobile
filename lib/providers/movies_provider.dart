import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pelitoday/helpers/debouncer.dart';
import 'package:pelitoday/models/models.dart';
import 'package:pelitoday/models/now_playing_response.dart';
import 'package:pelitoday/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {

  String _apiKey = '1865f43a0549ca50d341dd9ab8b29f49';
  String _language = 'en-US';
  String _baseUrl = 'api.themoviedb.org';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> movieCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500)
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider() {
    print('Movies Provider initialized');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1] ) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });
    
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final requestData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(requestData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    print(_popularPage);
    _popularPage++;
    final requestData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(requestData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if(movieCast.containsKey(movieId)) {
      return movieCast[movieId]!;
    }
    final requestData = await _getJsonData('3/movie/$movieId/credits', _popularPage);
    final castResponse = CastResponse.fromJson(requestData);
    movieCast[movieId] = castResponse.cast;
    return castResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });
    
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.searchMovies(query);
      this._suggestionStreamController.add(results);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) { 
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}