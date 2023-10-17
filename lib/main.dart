// ignore_for_file: avoid_unnecessary_containers, avoid_print, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';
import 'dart:typed_data';
import 'package:camera_clobot/imager/src/images_merge_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CaptureScreen(),
    );
  }
}

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  CaptureScreenState createState() => CaptureScreenState();
}

class CaptureScreenState extends State<CaptureScreen> {
  XFile? image1;
  XFile? image2;
  XFile? image3;
  XFile? image4;

  ui.Image? img1;
  ui.Image? img2;
  ui.Image? img3;
  ui.Image? img4;

  ui.Image? imgFinal;
  Uint8List? uint8list;

  PermissionStatus? status;

  Future<Uint8List> getXFileBytes(XFile file) async {
    List<int> bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }

  Future<ui.Image> getUiImageFromXFile(XFile file) async {
    Uint8List bytes = await getXFileBytes(file);
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  Future<XFile?> captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print(pickedFile.path);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Custum Image"),
              content: const Text("User Cancelled Image"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK")),
              ],
            );
          });
      return null;
    }
    return pickedFile;
  }

  @override
  void initState() {
    super.initState();
    permissionTake();
  }

  Future<void> permissionTake() async {
    status = await Permission.manageExternalStorage.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Capture App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Tap On Boxes to Select Images',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.0,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    image1 = await captureImage();
                    setState(() {});
                    if (image1 != null) {
                      img1 = await getUiImageFromXFile(image1!);
                    }
                    setState(() {});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: image1 == null
                          ? const Center(
                              child: Text(
                                'Image 1',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Image.file(
                              File(image1!.path),
                              fit: BoxFit.cover,
                            )),
                ),
                GestureDetector(
                  onTap: () async {
                    image2 = await captureImage();
                    setState(() {});
                    if (image2 != null) {
                      img2 = await getUiImageFromXFile(image2!);
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: image2 == null
                        ? const Center(
                            child: Text(
                              'Image 2',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Image.file(
                            File(image2!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    image3 = await captureImage();
                    setState(() {});
                    if (image3 != null) {
                      img3 = await getUiImageFromXFile(image3!);
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: image3 == null
                        ? const Center(
                            child: Text(
                              'Image 3',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Image.file(
                            File(image3!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    image4 = await captureImage();
                    setState(() {});
                    if (image4 != null) {
                      img4 = await getUiImageFromXFile(image4!);
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: image4 == null
                        ? const Center(
                            child: Text(
                              'Image 4',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Image.file(
                            File(image4!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                print("MERGE IMAGES PROCESS...");
                ui.Image image = await ImagesMergeHelper.margeImages(
                    [img1!, img2!, img3!, img4!],
                    direction: Axis.vertical,
                    fit: true,
                    backgroundColor: Colors.white);
                imgFinal = image;
                ByteData? byteData = await imgFinal!.toByteData();
                uint8list = Uint8List.fromList(byteData!.buffer.asUint8List());
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: const Text("Custum Image"),
                    content: Text(byteData.buffer.asInt8List().toString()),
                  );
                });
                setState(() {});
                print("++++++++++++++++++++++++++++++++++++++");
                print(imgFinal);
              },
              child: const Text("Merge Images")),
          const SizedBox(
            height: 20,
          ),
          // Center(
          //   child: Image.memory(uint8list!),
          // ),
        ],
      ),
    );
  }
}
