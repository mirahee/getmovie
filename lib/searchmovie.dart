import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:ndialog/ndialog.dart';

/*Future<Movie> fetchMovie() async {
  final response = await http
      .get(Uri.parse('https://www.omdbapi.com/?i=tt3896198&apikey=63b476de'));
        /*TextEditingController textEditingController = TextEditingController();
        String search = textEditingController.text;
        var apikey = "63b476de";
        var url = Uri.parse('https://www.omdbapi.com/?t=$search&apikey=$apikey');   
        var response = await http.get(url);
        var rescode = response.statusCode;*/
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Movie.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}*/



/*class Movie {
  final String title;
  final String year;
  final String genre;
  final String poster;
  //final String ombd;

  Movie({
    required this.title,
    required this.year,
    required this.genre,
    required this.poster,
    //required this.ombd
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      genre: json['Genre'],
      poster: json['Poster'],
      //ombd: json['ombd']
    );
  }
}*/

 void _confirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Search for Movie",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Do you want to search this one ${search.text} ?",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onPressed: () {
                getMovie(search.text);
              },
            ),
            TextButton(
              child: const Text("No",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

class SearchMovie extends StatefulWidget {
  //const SearchMovie({Key? key}) : super(key: key);
  const SearchMovie({key, required this.title}) : super(key: key);
  final String title;
  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  //final searchTextController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  String desc = " ";
  var poster_ = " ";
  var title = "";
  var year = "";
  var genre = "";

  String searchText = "";
  //late Future<Movie> futureMovie;


  /*@override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
    //futureMovie = fetchAlbum();
  }*/
  @override
  void initState() {
    super.initState();
    //futureMovie = fetchMovie();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Get Movie')),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Row(children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: textEditingController,
                    decoration:
                        const InputDecoration(hintText: 'Enter a movie name'),
                  ),
                ),
                /*IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Get Movie',
                  onPressed: () {
                    setState(() {
                      searchText = textEditingController.text;
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    });
                  },
                ),*/
              ]),
              padding: const EdgeInsets.all(10),
            ),
            ElevatedButton(onPressed: getmovie, child: const Text("Search")),
            Text(desc,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.image_outlined,
                    size: 32,
                  ),
                  Text(
                    "Poster",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Image.network(
                poster_,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      'assets/images/superman.jpg');
                },
              ),
            ],
          ),
        ]),


           /* Center(
              child: FutureBuilder<Movie>(
                future: futureMovie,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.genre);
                    
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),*/
          
        );     
  }
  getmovie() async {
    var apiid = "63b476de";
    var url = Uri.parse(
        'http://www.omdbapi.com/?t=&apikey=$apiid&units=metric');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        var title = parsedJson['Title'];
        var year = parsedJson['Year'];
        var genre = parsedJson['Genre'];
        var poster = parsedJson['Poster'];

        desc =
            '\nTitle: $title \nYear: $year \nGenre: $genre \n ';
        poster_ = '$poster';

        Fluttertoast.showToast(
            msg: "Movie Found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.deepPurple,
            timeInSecForIosWeb: 2,
            fontSize: 16.0);
      });
   
    } else {
      setState(() {
        desc = "No record found!";
      });
    }
  }
}
