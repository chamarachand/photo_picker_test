import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_picker_test/home/cubit/home_cubit.dart';
import 'package:photo_picker_test/home/cubit/home_state.dart';
import 'package:photo_picker_test/home/utils/alert_dialogs.dart';
import 'package:photo_picker_test/home/widgets/get_image.dart';
import 'package:photo_picker_test/home/widgets/upload_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<File> _images = [];
    int _imageCount = _images.length;
    bool _imagesUploaded = false;
    const int maxImageCount = 10;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Image to pdf")),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Text("Image Upload"),
                      GestureDetector(
                        child: const Icon(Icons.add_a_photo),
                        onTap: () {
                          if (_images.length >= maxImageCount) {
                            alertWarningDialog(context, "Max image limit reached",
                                "You cannot add more than $maxImageCount images");
                          } else {
                            BlocProvider.of<HomeCubit>(context).isLoading();
                            getImage(context, _images);
                            BlocProvider.of<HomeCubit>(context).isLoaded();
                          }
                        },
                      )
                    ],
                  ),
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return const CircularProgressIndicator();
                    }
                    return _images.isEmpty
                        ? Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 100,
                                height: 100,
                                // decoration: const BoxDecoration(
                                //   image: DecorationImage(
                                //     image: AssetImage("assets/images/error_load_image.png"),
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                              ),
                            ),
                          )
                        : uploadedImage(context, _images);
                  },
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: 150,
                        height: 80,
                        // child: elevatedTabButtonHalf(
                        //     context: context,
                        //     title: "Save",
                        //     functionOnTap: () {
                        //       CompetitorActivityDetails details = CompetitorActivityDetails(
                        //         competitor: _competitorNameController.text,
                        //         territory: _territoryController.text,
                        //         promotion: _promoDetailsController.text,
                        //         promotionType: _selectedPromoType?.type,
                        //         product: _productCategoryController.text,
                        //         photo: _images.map((image) => image.path).toList(),
                        //       );

                        //       BlocProvider.of<HomeCubit>(context)
                        //           .addCompetitorActivityDetails(details);
                        //     }),
                        child: ElevatedButton(
                          child: Text("Save"),
                          onPressed: () {
                            // List<String>? images = _images.map((image) => image.path).toList();
                            // BlocProvider.of<HomeCubit>(context).saveAsPdf(_images);
                          },
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
