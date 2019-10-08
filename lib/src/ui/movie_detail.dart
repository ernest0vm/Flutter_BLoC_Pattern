import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/result_model.dart';
import '../blocs/detail_movies_bloc.dart';

class MovieDetail extends StatelessWidget {

  final int index;

// In the constructor, require a index.
  MovieDetail({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    detailBloc.getAllDetails(index);
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Detail"),
      ),
      body: StreamBuilder(
        stream: detailBloc.getDetails,
        builder: (context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.hasData) {
            return detailView(snapshot, context);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget detailView(AsyncSnapshot<Result> snapshot, BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 12,
                child: Image.network(
                    'https://image.tmdb.org/t/p/w185${snapshot.data
                        .poster_path}',
                    fit: BoxFit.fill,
                    scale: 0.5
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  children: <Widget>[
                    Text(snapshot.data.title, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),
                    Text(snapshot.data.original_title,
                      style: TextStyle(fontSize: 14,),)
                  ]),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Release date:"),
                        Text(snapshot.data.release_date),
                      ]),
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Popularity:"),
                        Text(snapshot.data.popularity.toString()),
                      ]),
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Vote Count:"),
                        Text(snapshot.data.vote_count.toString()),
                      ]),
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Vote Average:"),
                        Text(snapshot.data.vote_average.toString()),
                      ]),
                ],
              ),
            ),

            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Original Language:\n" + snapshot.data.original_language,
                      style: TextStyle(fontSize: 14),),
                  ],)
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Text("Overview:\n" + snapshot.data.overview,
                textAlign: TextAlign.justify,),
            ),

            Center(
              child: RaisedButton(
                onPressed: () {
                  // Navigate back to first route when tapped.
                  Navigator.pop(context);
                },
                child: Text('Go back!'),
              ),
            )
          ],
        ),
      ),
    );
   }
  }
