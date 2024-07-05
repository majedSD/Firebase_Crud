import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageImageShowScreen extends StatefulWidget {
  const StorageImageShowScreen({super.key});

  @override
  State<StorageImageShowScreen> createState() => _StorageImageShowScreenState();
}

class _StorageImageShowScreenState extends State<StorageImageShowScreen> {
  FirebaseStorage firebaseStorage=FirebaseStorage.instance;
  List<String>allImageUrl=[];
  Future<void>getUrl()async{
    Reference rf=firebaseStorage.ref().child('laptops');
    ListResult result= await rf.listAll();
    List<String>Urls=[];
    for(var url in result.items){
      Urls.add(await url.getDownloadURL());
    }
    setState(() {
      allImageUrl=Urls;
    });
  }
  @override
  void initState() {
    super.initState();
    getUrl();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage Image Show'),
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
      ),
      body:allImageUrl.isEmpty?const Center(
        child: CircularProgressIndicator(),
      ):ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
              itemCount: allImageUrl.length,
              itemBuilder: (context, index) => ListTile(
                title: Text('This is laptop ${index + 1}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(allImageUrl[index]),
                ),
              ),
            ),
    );
  }
}
