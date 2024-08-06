  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:web_craft/home/view_model/home_provider.dart';

Widget buldIndicator() => Consumer<HomeProvider>(
    builder: (context,value,_) {
      return AnimatedSmoothIndicator(
            activeIndex:value.activeIndex ,
            count:value.sliderImage.length,
            effect: const ExpandingDotsEffect(
                dotWidth: 5,
                dotHeight: 5,
                activeDotColor: Colors.white,
                expansionFactor: 1.5),
          );
    }
  );
