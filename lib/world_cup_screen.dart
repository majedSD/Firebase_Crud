import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frebase_crud/match_summary_screen.dart';

import 'Model/match_summary.dart';

class WorldCupScreen extends StatefulWidget {
  const WorldCupScreen({super.key});

  @override
  State<WorldCupScreen> createState() => _WorldCupScreenState();
}

class _WorldCupScreenState extends State<WorldCupScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference =
      firebaseFirestore.collection('worldcup');
  List<MatchSummary> matchSummaryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match List'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: collectionReference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshots.hasData) {
              matchSummaryList.clear();
              for (QueryDocumentSnapshot element in snapshots.data!.docs) {
                matchSummaryList.add(
                  MatchSummary(
                      element.get('title'),
                      element.get('goal'),
                      element.get('Time'),
                      element.get('Total Time'),
                      element.id),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: matchSummaryList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MatchSummaryScreen(
                                    matchSummary: matchSummaryList[index]),
                              ));
                        },
                        child: ListTile(
                          title: Text(matchSummaryList[index].id),
                        ),
                      );
                    }),
              );
            }
            return const SizedBox();
          }),
    );
  }
}
