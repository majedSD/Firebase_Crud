import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frebase_crud/Authentication/sign_in_screen.dart';
import 'package:frebase_crud/Cloud_Firestore/match_summary_screen.dart';
import 'package:get/get.dart';

import '../Model/match_summary.dart';

class WorldCupScreen extends StatefulWidget {
  const WorldCupScreen({super.key});

  @override
  State<WorldCupScreen> createState() => _WorldCupScreenState();
}

class _WorldCupScreenState extends State<WorldCupScreen> {
  TextEditingController titleTEController = TextEditingController();
  TextEditingController goalTEController = TextEditingController();
  TextEditingController timeTEController = TextEditingController();
  TextEditingController totalTimeTEController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference =
      firebaseFirestore.collection('worldcup');
  List<MatchSummary> matchSummaryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Cup match list'),
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionReference.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshots.hasError) {
            return Center(
              child: Text(snapshots.error.toString()),
            );
          }
          if (snapshots.hasData) {
            matchSummaryList.clear();
            for (QueryDocumentSnapshot element in snapshots.data!.docs) {
              matchSummaryList.add(
                MatchSummary(element.get('title'), element.get('goal'),
                    element.get('Time'), element.get('Total Time'), element.id),
              );
            }
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: matchSummaryList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(matchSummaryList[index].title),
                    trailing: Wrap(
                      children: [
                        IconButton(
                            onPressed: () {
                              ShowModalBottomSheet(matchSummaryList[index].id);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              collectionReference
                                  .doc(matchSummaryList[index].id)
                                  .delete();
                            },
                            icon: const Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              Get.to(MatchSummaryScreen(
                                  matchDetails: matchSummaryList[index]));
                            },
                            icon: const Icon(Icons.arrow_forward))
                      ],
                    ),
                  );
                });
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar:BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              child: Icon(Icons.add),
              onTap:(){
                ShowModalBottomSheet('0') ;
              },
            ),
            label:'Add',
            backgroundColor:Colors.grey,
          ),
          BottomNavigationBarItem(
            icon:InkWell(
              child: const Icon(Icons.logout),
              onTap: (){
                FirebaseAuth.instance.signOut();
                Get.to(const SignInScreen());
              },
            ),
            label:'Log out',
            backgroundColor:Colors.grey,
          )
        ],
      ),
    );
  }

  ShowModalBottomSheet(String id) {
    timeTEController.clear();
    titleTEController.clear();
    totalTimeTEController.clear();
    goalTEController.clear();
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: [
                TextFormField(
                  controller: titleTEController,
                  decoration: const InputDecoration(hintText: 'Enter title'),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: goalTEController,
                  decoration: const InputDecoration(hintText: 'Enter goal'),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: timeTEController,
                  decoration: const InputDecoration(hintText: 'Enter time'),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: totalTimeTEController,
                  decoration:
                      const InputDecoration(hintText: 'Enter total Time'),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      ///You must on mind document id kuno somoy update kora jai nah
                      ///TODO(((Set)))--Set er maddoma (document id soho add) and update kora jai
                      ///TODO--Document id sob somoy unique hoi and not changeable and document id document creat korar somoy ekbar generate hoi
                      id == '0'

                          ///set document add
                          ? collectionReference
                              .doc(titleTEController.text)
                              .set({
                              'title': titleTEController.text.trim(),
                              'goal': goalTEController.text.trim(),
                              'Time': timeTEController.text.trim(),
                              'Total Time': totalTimeTEController.text.trim()
                            })

                          ///set document update
                          : collectionReference.doc(id).set({
                              'title': titleTEController.text.trim(),
                              'goal': goalTEController.text.trim(),
                              'Time': timeTEController.text.trim(),
                              'Total Time': totalTimeTEController.text.trim()
                            });

                      ///Todo(((update)))--ekta id er information update kora jai
                      /*
                      :collectionReference.doc(id).update({
                    'title':titleTEController.text.trim(),
                    'goal':goalTEController.text.trim(),
                    'Time':timeTEController.text.trim(),
                    'Total Time':totalTimeTEController.text.trim()
                  });*/

                      ///TODO(((Add)))--only data add kora jai and document id oto generate hoi
                      /*collectionReference.add({
                    'title':titleTEController.text.trim(),
                    'goal':goalTEController.text.trim(),
                    'Time':timeTEController.text.trim(),
                    'Total Time':totalTimeTEController.text.trim()
                  });*/
                      Navigator.pop(context);
                    },
                    child: const Text('Add')),
              ],
            ));
  }
}
