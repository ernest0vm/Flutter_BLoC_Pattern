import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_pattern/src/ui/movie_detail.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return
          new GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail(index: index,)));
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.network(
                        'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                        fit: BoxFit.cover
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(150, 0, 0, 0),
                        //border: Border.all(color: Colors.black, width: 3),
                        //borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                      child: Text(snapshot.data.results[index].title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,),
                    ),
                  ),

                ],
              ),
              ),
          );
        });
  }
}