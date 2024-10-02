import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_picker_test/home/cubit/home_cubit.dart';
import 'package:photo_picker_test/home/screens/home_screen.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

void main() async {
  imagePickerSetup();
  runApp(const MyApp());
}

void imagePickerSetup() {
  final ImagePickerPlatform imagePickerImplementation = ImagePickerPlatform.instance;
  if (imagePickerImplementation is ImagePickerAndroid) {
    imagePickerImplementation.useAndroidPhotoPicker = true;
    ImagePickerAndroid().useAndroidPhotoPicker = true;
    debugPrint("Image picker setup success 1");
  }
  debugPrint("Image picker setup success 2");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomeScreen(),
        ));
  }
}
