import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsi/base/api_data_source.dart';
import 'package:responsi/model/matches_model.dart';
import 'package:responsi/ui/page_detail_matches.dart';

class PageListMatches extends StatefulWidget {
  const PageListMatches({Key? key}) : super(key: key);

  @override
  State<PageListMatches> createState() => _PageListMatchesState();
}

class _PageListMatchesState extends State<PageListMatches> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Piala Dunia 2022')
          ),
          body: Container(
            child: FutureBuilder(
              future: ApiDataSource.instance.loadMatches(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasError){
                  return _buildErrorSection();
                }
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index){
                        MatchesModel matchesModel = MatchesModel.fromJson(snapshot.data[index]);
                        return InkWell(
                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PageDetailMatches(id: matchesModel.id!))
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Image.network("https://flagcdn.com/256x192/" + matchesModel.homeTeam!.country!.substring(0, 2).toLowerCase() + ".png"),
                                      ),
                                      Text(matchesModel.homeTeam!.name!)
                                      //Text(snapshot.data[index])
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(matchesModel.homeTeam!.goals!.toString()),
                                      Text(" - "),
                                      Text(matchesModel.awayTeam!.goals!.toString())
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Image.network("https://flagcdn.com/256x192/" + matchesModel.awayTeam!.country!.substring(0, 2).toLowerCase() + ".png"),
                                      ),
                                      Text(matchesModel.awayTeam!.name!)
                                      //Text(snapshot.data[index])
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                }
                return _buildLoadingSection();
              },
            ),
          )
        )
    );
  }
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

