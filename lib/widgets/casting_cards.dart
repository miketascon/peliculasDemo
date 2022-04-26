import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/providers/providers.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards(this.movieId);
  @override
  Widget build(BuildContext context) {
    final moviesProvides = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvides.getMovieCast(this.movieId),
      builder: (_, AsyncSnapshot<List<Cast>> castSnapshot) {

        if ( !castSnapshot.hasData ) { 
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator()
          );
        }

        final List<Cast> cast = castSnapshot.data!;

        return Container(
          width: double.infinity,
          height: 180,
          margin: EdgeInsets.only(bottom: 30),
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastCard(cast[index])),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(actor.fullProfileImg),
                placeholder: AssetImage('assets/no-image.jpg'),
                height: 140,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
