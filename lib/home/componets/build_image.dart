  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_craft/home/componets/error_image_placeholder.dart';
import 'package:web_craft/home/view_model/home_provider.dart';

Widget buildImage(int index) => Consumer<HomeProvider>(
    builder: (contex,value,_) {
      return Image.network(
           value.sliderImage[index],
            errorBuilder: (context, error, stackTrace) {
              return const ErrorImagePlaceHolder();
            },
            fit: BoxFit.fill,
          );
    }
  );