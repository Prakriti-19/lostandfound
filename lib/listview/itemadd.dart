import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lostandfound/screens/homescreen.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../authenticate/auth.dart';


class P_list extends StatefulWidget {

  String uid;
  String name;
      P_list({required this.uid,required this.name});
  @override
  _P_listState createState() => _P_listState();
}

class _P_listState extends State<P_list> {

  String p_name = '';
  String cat = '';
  String desc = '';
  String? url;
  final _formKey = GlobalKey<FormState>();
  File? _image;
  @override
  Future getImage() async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        print("reached set state");
        _image = File(image!.path);
        // url=uploadPic(_image);
        if(_image==null){
          print("image is null");
        }
        else{
          print("image is not null");
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  Future<String> uploadPic() async{
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" +DateTime.now().toString());
    UploadTask uploadTask= ref.putFile(_image!);
    uploadTask.whenComplete(() async{url = await ref.getDownloadURL();
    });
    print("here we go");
    print(url);
    if(url!=null)
      return url!;
    else{
      return url= await ref.getDownloadURL();
    }
  }
  addproducts() async{}
  final List<String> items = ['Lost', 'Found'];
  Widget build(BuildContext context) {
    String name = widget.name;
    String uid = widget.uid;
    final user = Provider.of<Usser?>(context);
    return Scaffold(
        appBar: new PreferredSize(
          child: new Container(
            padding:
            new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: new Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
              child: new Text('Enter Details',
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
                            child: Column(children: [_image != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.file(_image!, width: 150, height: 150, fit: BoxFit.cover),
                            )
                                : ClipRRect(borderRadius: BorderRadius.circular(50.0),
                                child: FlutterLogo(size: 150)
                            ),
                              SizedBox(height: 30.0),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              ),
                              TextFormField(
                                validator: (val) => val!.isEmpty
                                    ? 'please enter your product name'
                                    : null,
                                onChanged: (val) => setState(() => p_name = val),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              ),
                              TextFormField(
                                validator: (val) => val!.isEmpty
                                    ? 'please enter your product description'
                                    : null,
                                onChanged: (val) => setState(() => desc = val),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                  width: 300,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 30),
                                  child: DropdownButtonFormField(
                                      dropdownColor: Colors.orange[50],
                                      focusColor: Color.fromRGBO(12,65,96,1),
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
                                    decoration: const BoxDecoration(color: Colors.blue),
                                    child: Row(
                                      children: [
                                        FloatingActionButton(
                                          onPressed: () { getImage();},
                                          backgroundColor: Color.fromRGBO(12,65,96,1),
                                          child: Icon(Icons.add_a_photo_outlined),
                                        ),
                                        Text(' Add item image'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              RaisedButton(
                                color: Colors.white70,
                                highlightElevation: 0,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 150,
                                        height: 55,
                                        decoration: BoxDecoration(
                                         color: Color.fromRGBO(12,65,96,1)),
                                        child: Center(
                                          child: Text(
                                            'Add to Sell',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                        ),
                                      )
                                    ]),
                                onPressed: ()  async {

                                  if (_formKey.currentState!.validate() ) {
                                    final CollectionReference productCollection = FirebaseFirestore.instance.collection('product');
                                    await productCollection.add({
                                      'url': url,
                                      'name': p_name,
                                      'cat': cat,
                                      'desc': desc,
                                    }).then((value)
                                    {Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));});
                                  }
                                },
                                padding: EdgeInsets.symmetric(vertical: 0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(58.0))),)
                            ])))
                  ]),
                ))));
  }
}
