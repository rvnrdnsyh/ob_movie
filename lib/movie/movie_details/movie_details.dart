import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/movie/movie_details/movie_detail_view_model.dart';
// import 'package:moviedb/movie/movie_details/widget/movie_detail_cast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        context.read(movieDetailViewModelProvider.notifier).loadData(id));

    return Scaffold(body: Consumer(builder: (context, watch, child) {
      final state = watch(movieDetailViewModelProvider);
      // print(state.data);
      if (state is Loading) {
        return Container(
            height: 400,
            width: double.infinity,
            alignment: Alignment.center,
            child: CircularProgressIndicator());
      } else {
        // return MovieDetailCast();
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 360,
                padding:
                    EdgeInsets.only(top: 37, left: 20, right: 20, bottom: 5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(state.data.backdrop),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstOut),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: GestureDetector(
                              onTap: () => {Navigator.pop(context)},
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            )),
                        Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: GestureDetector(
                              onTap: () => {},
                              child: Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                state.data.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // ListView.builder(
                            //   scrollDirection: Axis.horizontal,
                            //     itemCount: state.data.genres.length,
                            //     shrinkWrap: true,
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return Text(state.data.genres[index].name);
                            //     },
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                Text(
                                  '  ${state.data.rating.toString()} / 10',
                                  style: TextStyle(
                                      color: Color(0XFF777777), fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color: Color(0XFFA4A3A9),
                                  size: 16,
                                ),
                                Text(
                                  '  ${state.data.voted} Users',
                                  style: TextStyle(
                                      color: Color(0XFF777777), fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: () => {},
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Color(0XFFE82626),
                                  ),
                                  height: 30,
                                  width: 160,
                                  // padding:
                                  // EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  child: Text("Watch Now",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ))
                          ],
                        ),
                        Container(
                          height: 190,
                          width: 106,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(state.data.poster),
                              fit: BoxFit.cover,
                              // colorFilter: new ColorFilter.mode(
                              //     Colors.black.withOpacity(0.6), BlendMode.dstATop),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Synonpsis'),
                    Text(
                      'Synonpsis',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 70,
                      child: Text(
                        state.data.synopsis,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trailer',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: state.data.trailerPath,
                        flags: YoutubePlayerFlags(
                          // hideControls: true,
                          hideThumbnail: true,
                          controlsVisibleAtStart: true,
                          autoPlay: false,
                          mute: false,
                        ),
                      ),
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                      progressColors: ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.amberAccent,
                      ),
                      onReady: () => {print('Youtube Ready')},
                    ),
                    // Container(
                    //   height: 250,
                    //   color: Colors.blue,
                    // )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cast',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          child: Text('See All'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                // color: Colors.blueGrey,
                height: 230,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (BuildContext contex, int index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(2.5),
                          height: MediaQuery.of(context).size.width / 4 - 15,
                          width: MediaQuery.of(context).size.width / 4 - 15,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: NetworkImage(
                                    state.data.cast[index].profileImage),
                                fit: BoxFit.cover,
                                // colorFilter: new ColorFilter.mode(
                                //     Colors.black.withOpacity(0.6), BlendMode.dstOut),
                              ),
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        Container(
                          margin: EdgeInsets.all(2.5),
                          height: MediaQuery.of(context).size.width / 4 - 15,
                          width: MediaQuery.of(context).size.width / 4 - 15,
                          child: Text(
                            state.data.cast[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        );
      }
    }));
  }
}
