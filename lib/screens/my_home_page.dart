import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final ImagePicker _picker = ImagePicker();
  File? _pickedFile;
  List? _result;
  bool _loading = false;

  Future<void>detectImage(File image)async{
    setState(() {
      _loading = true;
    });
    List? output = await Tflite.runModelOnImage(path: image.path, numResults: 2, threshold: 0.6, imageMean: 127.5, imageStd: 127.5);
    print(output);
    setState(() {
      _result = output;
      _loading = false;
    });
  }

  Future<void>loadModel()async{
    await Tflite.loadModel(model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  Future<void>_pickImage(ImageSource selectedsource)async{
    final XFile? image = await _picker.pickImage(source: selectedsource);
    if(image != null){
      setState(() {
        _pickedFile = File(image.path);
      });
      detectImage(_pickedFile!);
    }
  }
  @override
  void initState() {
    ///Load our trained model from asset file
    loadModel().then((value){

    });
    super.initState();
  }


  void _incrementCounter() {
    setState(() {
      _pickedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1.0,
        centerTitle: true,
      ),
      */
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50.0,),
                Text("Wellcome aboard", style: TextStyle(fontSize: 32),),
                SizedBox(height: 20.0,),
                Text( _result != null && _result![0] != null ? "Your scan result" : "Proceed to new Scan", style: TextStyle(fontSize: 25),),

                SizedBox(height: 20.0,),
                _pickedFile != null ? Container(
                    child: Column(children: [
                      Image.file(_pickedFile!, height: 200, width: double.infinity, fit: BoxFit.cover,),
                      _result != null && _result![0] != null ? Text("${_result![0]['label']}", style: TextStyle(fontSize: 22),)
                          :
                          Text("")
                    ],)
                ): Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Icon(Icons.image, size: 30, color: Colors.amber,),
                          onTap: ()async{
                            await _pickImage(ImageSource.gallery);
                          },
                        ),
                      ),

                      Expanded(
                        child: InkWell(
                          child: Icon(Icons.camera_alt, size: 30, color: Colors.amber,),
                          onTap: ()async{
                            await _pickImage(ImageSource.camera);
                          },
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: _incrementCounter,
        tooltip: 'PickImage',
        child: Icon(Icons.add, color: Colors.amber,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: _createBottomAppBar(),

    );
  }

  BottomAppBar _createBottomAppBar() {
    return BottomAppBar(
      elevation: 2.0,
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
          ],
        ),
      ),
    );
  }
}
