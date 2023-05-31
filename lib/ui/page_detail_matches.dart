import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsi/model/detail_matches_model.dart';

import '../base/api_data_source.dart';

class PageDetailMatches extends StatefulWidget {
  final id;
  const PageDetailMatches({Key? key, required this.id}) : super(key: key);

  @override
  State<PageDetailMatches> createState() => _PageDetailMatchesState();
}

class _PageDetailMatchesState extends State<PageDetailMatches> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Match ID : " + widget.id!,
              style: TextStyle(
                fontSize: 16.0
              ),
            ),
          ),
          body: _buildDetailedMatchesBody(widget.id)
        )
    );
  }
}

Widget _buildDetailedMatchesBody(String id){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadDetailMatches(id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasError){
          return _buildErrorSection();
        }
        if(snapshot.hasData){
          DetailMatchesModel detailMatchesModel = DetailMatchesModel.fromJson(snapshot.data);
          return _buildSuccessSection(detailMatchesModel, context);
        }
        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Error Occured"),
  );
}

Widget _buildLoadingSection(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator()
      ],
    ),
  );
}

Widget _buildSuccessSection(DetailMatchesModel data, BuildContext context){
  return Container(
    padding: EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 150,
                  child: Image.network("https://flagcdn.com/256x192/" + data.homeTeam!.country!.substring(0, 2).toLowerCase() + ".png"),
                ),
                Text(data.homeTeam!.name!)
                //Text(snapshot.data[index])
              ],
            ),
            Row(
              children: [
                Text(data.homeTeam!.goals!.toString()),
                Text(" - "),
                Text(data.awayTeam!.goals!.toString())
              ],
            ),
            Column(
              children: [
                Container(
                  width: 150,
                  child: Image.network("https://flagcdn.com/256x192/" + data.awayTeam!.country!.substring(0, 2).toLowerCase() + ".png"),
                ),
                Text(data.awayTeam!.name!)
                //Text(snapshot.data[index])
              ],
            )
          ],
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("Stadium : " + data.venue!),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("Location : " + data.location!),
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all()
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Statistics",
                  style: TextStyle(
                      fontSize: 26.0,
                  )
              ),
              Text("Ball Possession"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.homeTeam!.statistics!.ballPossession.toString()),
                  Text(" - "),
                  Text(data.awayTeam!.statistics!.ballPossession.toString())
                ],
              ),
              Text("Shot"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.homeTeam!.statistics!.attemptsOnGoal.toString()),
                  Text(" - "),
                  Text(data.awayTeam!.statistics!.attemptsOnGoal.toString())
                ],
              ),
              Text("Shot on Goal"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.homeTeam!.statistics!.kicksOnTarget.toString()),
                  Text(" - "),
                  Text(data.awayTeam!.statistics!.kicksOnTarget.toString())
                ],
              ),
              Text("Corners"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.homeTeam!.statistics!.corners.toString()),
                  Text(" - "),
                  Text(data.awayTeam!.statistics!.corners.toString())
                ],
              ),
              Text("Offside"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.homeTeam!.statistics!.offsides.toString()),
                  Text(" - "),
                  Text(data.awayTeam!.statistics!.offsides.toString())
                ],
              ),
              Text("Fouls"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.homeTeam!.statistics!.foulsCommited.toString()),
                  Text(" - "),
                  Text(data.awayTeam!.statistics!.foulsCommited.toString())
                ],
              ),
              Text("Pass Accuracy"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(passAccu(data.homeTeam!.statistics!.passesCompleted!, data.homeTeam!.statistics!.passes!).toString() + "%"),
                  Text(" - "),
                  Text(passAccu(data.awayTeam!.statistics!.passesCompleted!, data.awayTeam!.statistics!.passes!).toString() + "%"),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Text("Referees : ",
            style: TextStyle(
              fontSize: 26.0
            )
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          height: MediaQuery.of(context).size.height/5,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.officials!.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all()
                    ),
                    width: 130,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network("https://upload.wikimedia.org/wikipedia/commons/5/5c/FIFA_series_logo.png"),
                        SizedBox(height: 4.0),
                        Text(data.officials![index].name.toString()),
                        SizedBox(height: 4.0),
                        Text(data.officials![index].role.toString())
                      ],
                    ),
                  ),
                );
              }
          ),
        )
      ],
    ),
  );
}

int passAccu(int a, int b){
  var pass = (a / b) * 100;
  return pass.round();
}