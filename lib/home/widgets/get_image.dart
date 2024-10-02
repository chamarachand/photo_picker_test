import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_picker_test/home/cubit/home_cubit.dart';
import 'package:photo_picker_test/home/utils/image_uplaoder.dart';

Future getImage(BuildContext dialogContext, List<File> _images) {
  return showDialog(
      context: dialogContext,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 250,
            child: Column(
              children: [
                Text("Please select picture mode"),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(dialogContext, true);
                        File? image = await ImageUploader.captureImage();
                        if (image!.path.isNotEmpty) {
                          _images.add(image);
                          BlocProvider.of<HomeCubit>(dialogContext).addImage(image);
                        }
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt_rounded),
                              onPressed: () async {
                                Navigator.pop(dialogContext, true);
                                File? image = await ImageUploader.captureImage();
                                if (image!.path.isNotEmpty) {
                                  _images.add(image);
                                  BlocProvider.of<HomeCubit>(dialogContext).addImage(image);
                                }
                              },
                            ),
                          ),
                          Text("Take Picture")
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(dialogContext, true);
                        File? image = await ImageUploader.pickImage();
                        if (image != null && image.path.isNotEmpty) {
                          _images.add(image);
                          BlocProvider.of<HomeCubit>(dialogContext).addImage(image);
                        } else {
                          debugPrint("No image selected");
                        }
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                              icon: const Icon(Icons.photo),
                              onPressed: () async {
                                Navigator.pop(dialogContext, true);
                                File? image = await ImageUploader.pickImage();
                                if (image != null && image.path.isNotEmpty) {
                                  _images.add(image);
                                  BlocProvider.of<HomeCubit>(dialogContext).addImage(image);
                                } else {
                                  debugPrint("No image selected");
                                }
                              },
                            ),
                          ),
                          const Text("Select Picture")
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.orange,
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)), // foreground
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Center(
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                    ), // <-- Text
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
