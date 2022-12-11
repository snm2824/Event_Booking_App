import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class FourthRoute extends StatefulWidget {
 const FourthRoute({Key? key}) : super(key: key);
 @override
 _FourthRoute createState() => _FourthRoute();
}
class _FourthRoute extends State<FourthRoute> {
 FirebaseStorage storage = FirebaseStorage.instance;
 Future<void> _upload() async {
 FilePickerResult? result = await FilePicker.platform.pickFiles();
 final User? auth = FirebaseAuth.instance.currentUser;
 final uid = auth?.uid;
 if (result != null) {
 PlatformFile file = result.files.first;
 debugPrint(file.name);
Mohana R 195002073
 debugPrint(file.bytes.toString());
 debugPrint(file.size.toString());
 debugPrint(file.extension);
 debugPrint(file.path);
 // storage.ref(file.name).putFile(File(file.path.toString()),
 // SettableMetadata(customMetadata: {'uploaded_by': uid.toString()}));
 storage.ref().child("documents/" + uid! + "/" +
file.name).putFile(File(file.path.toString()));
 }
 }
 Future<List<Map<String, dynamic>>> _list() async{
 // List userFiles = [];
 List<Map<String, dynamic>> userFiles = [];
 final User? auth = FirebaseAuth.instance.currentUser;
 final uid = auth?.uid;
 final storageRef = FirebaseStorage.instance.ref().child("documents/" + uid! + "/");
 final listResult = await storageRef.listAll();
 for (var item in listResult.items) {
 debugPrint(item.name);
 userFiles.add({
 "fName": item.name,
 "fPath" : item.fullPath});
 }
 return userFiles;
 }
 // Delete the selected image
 // This function is called when a trash icon is pressed
 Future<void> _delete(String ref) async {
 await storage.ref(ref).delete();
 // Rebuild the UI
 setState(() {});
 }
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: Text("My Documents", style: TextStyle(color: Colors.black)),
 leading: GestureDetector(
 child: Icon( Icons.arrow_back_ios, color: Colors.black, ),
 onTap: () {
 Navigator.pop(context);
 } ,
 ),
 backgroundColor: Color(0xffef2e6c),
Mohana R 195002073
 ),
 body: Padding(
 padding: const EdgeInsets.all(20),
 child: Column(
 children: [
 Image.asset('assets/images/undraw_my_files_swob.png'),
 Row(
 mainAxisAlignment: MainAxisAlignment.spaceAround,
 children: [
 ElevatedButton.icon(
 onPressed: () => _upload(),
 icon: const Icon(Icons.file_upload_rounded),
 label: const Text('Upload file',style:TextStyle(fontSize: 20)),
 style: ElevatedButton.styleFrom(backgroundColor:Color(0xffef2e6c) )),
 // ElevatedButton.icon(
 // onPressed: () => _list(),
 // icon: const Icon(Icons.view_list_rounded),
 // label: const Text('View files'),
 // style: ElevatedButton.styleFrom(backgroundColor:Color(0xffef2e6c) )),
 ],
 ),
 Expanded(
 child: FutureBuilder(
 future: _list(),
 builder: (context,
 AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
 if (snapshot.connectionState == ConnectionState.done) {
 return ListView.builder(
 itemCount: snapshot.data?.length ?? 0,
 itemBuilder: (context, index) {
 final Map<String, dynamic> uFile=
 snapshot.data![index];
 return Card(
 margin: const EdgeInsets.symmetric(vertical: 10),
 child: ListTile(
 dense: false,
 // leading: fname,
 title: Text(uFile['fName']),
 //subtitle: Text(image['uploaded_by']),
 trailing: IconButton(
 onPressed: () => _delete(uFile['fPath']),
 icon: const Icon(
 Icons.delete,
 color: Color(0xffef2e6c),
 ),
 ),
 ),
 );
 },
Mohana R 195002073
 );
 }
 return const Center(
 child: CircularProgressIndicator(),
 );
 },
 ),
 ),
 ],
 ),
 ),
 );
 }
} 