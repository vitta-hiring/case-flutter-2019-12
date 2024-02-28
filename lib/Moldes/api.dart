import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Movies {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final String response;
  final String imdbVotes;

  Movies(
      this.title,
      this.year,
      this.rated,
      this.released,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.language,
      this.country,
      this.awards,
      this.poster,
      this.response,
      this.imdbVotes);

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      json['Title'],
      json['Year'],
      json['Rated'],
      json['Released'],
      json['Runtime'],
      json['Genre'],
      json['Director'],
      json['Writer'],
      json['Actors'],
      json['Plot'],
      json['Language'],
      json['Country'],
      json['Awards'],
      json['Poster'],
      json['Response'],
      json['imdbVotes'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Year'] = this.year;
    data['Rated'] = this.rated;
    data['Released'] = this.released;
    data['Runtime'] = this.runtime;
    data['Genre'] = this.genre;
    data['Director'] = this.director;
    data['Writer'] = this.writer;
    data['Actors'] = this.actors;
    data['Plot'] = this.plot;
    data['Language'] = this.language;
    data['Country'] = this.country;
    data['Awards'] = this.awards;
    data['Poster'] = this.poster;
    data['Response'] = this.response;
    return data;
  }
}