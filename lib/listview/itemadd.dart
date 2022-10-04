import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lostandfound/screens/homescreen.dart';

class P_list extends StatefulWidget {
  String uid;
  String name;
  String roll;
  String no;
  P_list(
      {required this.uid,
      required this.name,
      required this.roll,
      required this.no});
  @override
  _P_listState createState() => _P_listState();
}

class _P_listState extends State<P_list> {
  @override
  String p_name = '';
  String cat = '';
  String desc = '';
  String url = '';
  final _formKey = GlobalKey<FormState>();
  File? _image;
  Future<List<String>> avaiableDocuments() async {
    List<String> ids = [];

    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('product').get();
    snapshot.docs.forEach((element) {
      ids.add(element.id);
    });

    return ids;
  }

  Future<String> uploadPic() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image!);
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
    });
    if (url != null)
      return url!;
    else {
      return url = await ref.getDownloadURL();
    }
  }

  Future getImage() async {
    String name = widget.name;
    String uid = widget.uid;
    String roll = widget.roll;
    String no = widget.no;
    try {
      ImagePicker picker = ImagePicker();
      XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image == null) return;
      _image = File(image.path);
      Reference ref = FirebaseStorage.instance.ref().child('${p_name}.jpg');
      await ref.putFile(File(image!.path));
      ref.getDownloadURL().then((value) async {
        setState(() {
          url = value;
        });
        url = await uploadPic();
        DocumentReference productCollection =
            FirebaseFirestore.instance.collection('product').doc();
        productCollection.set({
          'roll': roll,
          'uno': no,
          'pid': productCollection.id,
          'url': url,
          'uid': uid,
          'uname': name,
          'name': p_name,
          'cat': cat,
          'desc': desc,
        });
        uploadPic();
        List<String> ids = await avaiableDocuments();
        for (int i = 0; i < ids.length; i++) {
          FirebaseFirestore.instance
              .collection('product')
              .doc(ids[i])
              .update({'pid': ids[i]});
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  addproducts() async {}
  final List<String> items = ['Lost', 'Found'];
  Widget build(BuildContext context) {
    String name = widget.name;
    String uid = widget.uid;
    return Scaffold(
        appBar: new PreferredSize(
          child: new Container(
            color: Color.fromRGBO(92, 104, 211, .5),
            padding:
                new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: new Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
              child: new Text(
                'Enter Details',
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
          preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
            child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Container(
                    child: SingleChildScrollView(
                        reverse: true,
                        child: Column(children: [
                          SizedBox(
                            height: 30,
                          ),
                          _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.file(_image!,
                                      width: 180,
                                      height: 180,
                                      fit: BoxFit.cover),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: FlutterLogo(size: 1)),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'Name'),
                              validator: (val) => val!.isEmpty
                                  ? 'please enter item name'
                                  : null,
                              onChanged: (val) => setState(() => p_name = val),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'Details'),
                              validator: (val) => val!.isEmpty
                                  ? 'please enter item description'
                                  : null,
                              onChanged: (val) => setState(() => desc = val),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                              width: 300,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 30),
                              child: DropdownButtonFormField(
                                  dropdownColor:
                                      Color.fromRGBO(12, 65, 96, 0.5),
                                  focusColor: Color.fromRGBO(12, 65, 96, 0.5),
                                  items: items.map((items) {
                                    return DropdownMenuItem(
                                        child: Text('${items}'), value: items);
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() => cat = val! as String);
                                  })),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                            child: SizedBox(
                              child: DecoratedBox(
                                decoration:
                                    const BoxDecoration(color: Colors.white70),
                                child: Row(
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () {
                                        getImage();
                                      },
                                      backgroundColor:
                                          Color.fromRGBO(92, 104, 211, .5),
                                      child: Icon(Icons.add_a_photo_outlined),
                                    ),
                                    Text(
                                      '     Add item image',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            color: Color.fromRGBO(92, 104, 211, .5),
                            highlightElevation: 0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 150,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(18)),
                                      color: Color.fromRGBO(92, 104, 211, .5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  )
                                ]),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }
                            },
                            padding: EdgeInsets.symmetric(vertical: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(58.0))),
                          )
                        ])))
              ]),
            ))));
  }
}
