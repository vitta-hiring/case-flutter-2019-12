import 'package:app_movie/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> movies = [];
  Future<void> fetchMovies() async {
    final url =
        Uri.parse('http://www.omdbapi.com?apikey=d12b4be8&s=batman&type=movie');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['Response'] == 'True') {
        setState(() {
          movies = jsonData['Search'];
        });
      } else {
        print(
            'Erro na consulta: ${jsonData['Error']}'); // Exibindo mensagem de erro se a consulta falhar
      }
    } else {
      print(
          'Falha na requisição. Código de status: ${response.statusCode}'); // Exibindo mensagem de falha na requisição
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMovies(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(children: [
          ListTile(
            
             leading: const Icon(Icons.search),
            title: const Text('Buscar Filme'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MovieSearchPage()));
            },
          ),
        ]),
        
      ),
      appBar: AppBar(
        title: const Text('Filmes'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
        toolbarHeight: 70,
        
    
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return SizedBox(
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: 15,
              options: CarouselOptions(
                  height: 300,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.55,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.5,
                  scrollDirection: Axis.horizontal),
              itemBuilder:
                  (BuildContext context, int intemIndex, int pageViewIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(1),
                    height: 300,
                    width: 200,
                    child: Image.network(
                      movie['Poster'],
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                    color: Colors.deepOrangeAccent,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
