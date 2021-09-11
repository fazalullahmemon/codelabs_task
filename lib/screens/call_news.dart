import 'package:codelabs_task/data/model/data_model.dart';
import 'package:codelabs_task/data/repository/news_repository.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallNews extends StatefulWidget {
  final String screenTitle;
  CallNews({required this.screenTitle});
  @override
  _CallNewsState createState() => _CallNewsState();
}

class _CallNewsState extends State<CallNews> {
  List<Datum> apiNewsData = [];
  Future<bool> getNewsData() async {
    List<Datum>? apiNews = await NewsRepository().fetchNews();
    apiNewsData = apiNews!;
    return true;
  }

  @override
  void initState() {
    // data = getNewsData();
    super.initState();
  }

  void _launchURL(String url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNewsData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.screenTitle),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                getNewsData();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: MediaQuery.of(context).size.width * 0.95,
                child: ListView.builder(
                  itemCount: apiNewsData.length,
                  itemBuilder: (context, index) {
                    return ExpandablePanel(
                      header: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "id: ${apiNewsData[index].id.toString()}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "title: ${apiNewsData[index].title}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      collapsed: Text(
                        "",
                      ),
                      expanded: Column(
                        children: [
                          Text(
                            "${apiNewsData[index].summary}",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(apiNewsData[index].link);
                            },
                            child: Text(
                              "${apiNewsData[index].link}",
                              style: TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.screenTitle),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
