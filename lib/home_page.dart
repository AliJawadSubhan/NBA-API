import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba/team/team.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeams();
  }

  Future<List<Team>> getTeams() async {
    List<Team> allTeams = [];
    var respone =
        await http.get(Uri.https('www.balldontlie.io', 'api/v1/teams'));
    var jsonData = jsonDecode(respone.body);
    for (var eacHtEAMS in jsonData['data']) {
      final team = Team(
        eacHtEAMS['abbreviation'],
        eacHtEAMS["full_name"],
        eacHtEAMS['city'],
      );
      allTeams.add(team);
    }
    return allTeams;
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
        backgroundColor: Color(0xFFFD7465),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFD7465), Color(0xFFFF9068)],
          ),
        ),

        // padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ));
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: const Icon(
                        Icons.sports_basketball,
                        color: Color(0xFFFD7465),
                        size: 40.0,
                      ),
                      title: Text(
                        snapshot.data![index].full_name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(
                        snapshot.data![index].city,
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          color: Color(0xFFFD7465),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          snapshot.data![index].abbreviation.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
