
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frebase_crud/world_cup_screen.dart';

import 'Model/model_class.dart';
class FirebaseCrudAppScreen extends StatefulWidget {
  const FirebaseCrudAppScreen({super.key});

  @override
  State<FirebaseCrudAppScreen> createState() => _FirebaseCrudAppScreenState();
}

class _FirebaseCrudAppScreenState extends State<FirebaseCrudAppScreen> {
  TextEditingController titleTEController=TextEditingController();
  TextEditingController subtitleTEController=TextEditingController();
  TextEditingController roleTEController=TextEditingController();
  List<Student>studentList=[];
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
 late CollectionReference collectionReference=firebaseFirestore.collection('students');
  Future<void>getStudentList()async{
    studentList.clear();
    final QuerySnapshot result=await collectionReference.get();
    for(QueryDocumentSnapshot element in result.docs){
      studentList.add(Student(
          element.get('name'),
          element.get('institution'),
          element.get('roll'),
          element.id,
        ),);
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Student List CRUD')),
        actions: [
          IconButton(onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const WorldCupScreen()));
          }, icon:const Icon(Icons.arrow_forward)),
        ],
        backgroundColor: Colors.pinkAccent,
        foregroundColor:Colors.black,
      ), 
      body: StreamBuilder<QuerySnapshot>(
          stream:collectionReference.orderBy('roll').snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
             if(snapshot.hasData){
               studentList.clear();
               for(QueryDocumentSnapshot element in snapshot.data!.docs){
                 studentList.add(Student(
                   element.get('name'),
                   element.get('institution'),
                   element.get('roll'),
                   element.id,
                 ),
                 );
               }
               return ListView.builder(
                   itemCount: studentList.length,
                   itemBuilder: (context, index) {
                     return ListTile(
                       leading: CircleAvatar(
                         child: Text(studentList[index].roll),),
                       title: Text(
                         studentList[index].name, style: const TextStyle(
                         fontWeight: FontWeight.bold,
                       ),),

                       subtitle: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(studentList[index].institution),
                           Wrap(
                             children: [
                               TextButton(onPressed: () {
                                ShowModalBottomSheet(studentList[index].id);
                               }, child: const Icon(Icons.edit)),
                               TextButton(onPressed: () {
                                  collectionReference.doc(studentList[index].id).delete();
                               },
                                   child: const Icon(Icons.delete_outline)),
                             ],
                           ),
                         ],
                       ),
                     );
                   }
               );
             }
             return const SizedBox();
          }
        ),
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          ShowModalBottomSheet('0');
        },
        child:const Icon(Icons.add),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ShowModalBottomSheet(String id) {
    titleTEController.clear();
    subtitleTEController.clear();
    roleTEController.clear();
    return showModalBottomSheet(context: context,
            builder:(context){
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleTEController,
                      decoration: const InputDecoration(
                        hintText:"Enter the title",
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: subtitleTEController,
                      decoration: const InputDecoration(
                          hintText:'Enter the subtitle'
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: roleTEController,
                      decoration: const InputDecoration(
                          hintText:'Enter the roll'
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.pinkAccent,
                      child: ElevatedButton(
                        onPressed: (){
                         id=='0'? collectionReference.doc('student${roleTEController.text.trim()}').set({
                            'name':titleTEController.text.trim(),
                            'institution':subtitleTEController.text.trim(),
                            'roll':roleTEController.text.trim()
                          }):
                          collectionReference.doc(id).update({
                            'name':titleTEController.text.trim(),
                            'institution':subtitleTEController.text.trim(),
                            'roll':roleTEController.text.trim()
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    ),
                  ],
                ),
              );
            }
        );
  }

}
