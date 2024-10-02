import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_picker_test/home/cubit/home_cubit.dart';

Widget uploadedImage(BuildContext context, List<File> _images) {
  return SizedBox(
    height: 100,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _images.length,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemBuilder: (builderContext, index) {
        return Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(_images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  final removedImage = _images.removeAt(index);
                  BlocProvider.of<HomeCubit>(context).removeImage(removedImage);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ))
        ]);
      },
    ),
  );
}
