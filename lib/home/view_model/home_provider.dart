import 'package:flutter/material.dart';
import 'package:web_craft/home/repo/home_repo.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepo homeRepo = HomeRepoImpli();

   List<String> sliderImage = ['','',''];

  int activeIndex = 0;

  changingActiveindex(int value) {
    activeIndex = value;
    notifyListeners();
  }


  
}
