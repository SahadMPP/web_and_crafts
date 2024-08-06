import 'package:flutter/material.dart';
import 'package:web_craft/home/view/blank_page.dart';
import 'package:web_craft/home/view/home_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

int currentIndex = 0; 
List<Widget> pages = [
  const HomePage(),
  const BlankPage(),
  const BlankPage(),
  const BlankPage(),
  const BlankPage(),
];

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
          currentIndex = index;
          });

        },
        showUnselectedLabels: true,
        backgroundColor: Colors.grey,
        unselectedItemColor: Colors.black87,
        selectedItemColor: Colors.black87,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items:  [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home,color: Colors.grey,),
            label: 'Home',
            backgroundColor: Colors.grey[200],
            activeIcon: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.home,color: Colors.white,),
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.category,color: Colors.grey,),
            label: 'Category',
             activeIcon:  CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.category,color: Colors.white,),
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,color: Colors.grey,),
            label: 'Cart',
             activeIcon:  CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.shopping_cart,color: Colors.white,),
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_offer,color: Colors.grey,),
            label: 'Offers',
             activeIcon:  CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.local_offer,color: Colors.white,),
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,color: Colors.grey,),
            label: 'Account',
             activeIcon:  CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.account_circle,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
