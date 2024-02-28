import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_movie/Moldes/api.dart';


class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({Key? key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  Future<Movies?> getFilme(String searchTerm) async {
    var url = 'http://www.omdbapi.com/?apikey=282b073f&t=$searchTerm';
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);

    if (data['Response'] == 'True') {
      return Movies(
        data['Title'],
        data['Year'],
        data['Rated'],
        data['Released'],
        data['Runtime'],
        data['Genre'],
        data['Director'],
        data['Writer'],
        data['Actors'],
        data['Plot'],
        data['Language'],
        data['Country'],
        data['Awards'],
        data['Poster'],
        data['Response'],
        data ['imdbVotes'],
      );
    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
      
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Pesquisar filme',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      String searchTerm = _searchController.text;
                      if (searchTerm.isNotEmpty) {
                        setState(() {
                          
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: getFilme(_searchController.text),
              builder: (context, AsyncSnapshot<Movies?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
                } else if (snapshot.data == null) {
                  return const Center();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text('Titulo: ${snapshot.data!.title}'),
                      ),
                      ListTile(
                        title: Text('Data de lançamento: ${snapshot.data!.year}'),
                      ),
                      ListTile(
                        title: Text('Gênero: ${snapshot.data!.genre}'),
                      ),
                      ListTile(
                        title: Text('Sinopse: ${snapshot.data!.plot}'),
                      ),
                      ListTile(
                        title: Text('Voto no IMDB: ${snapshot.data!.imdbVotes}'),
                      ),
                      Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(snapshot.data!.poster,
                    fit: BoxFit.cover,
                    ),
                    
                  ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}