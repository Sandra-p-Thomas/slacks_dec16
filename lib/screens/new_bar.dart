
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slacks_test/banner.dart';
import 'package:slacks_test/screens/cart_screen.dart';
import 'package:slacks_test/screens/catagories.dart';
import 'package:slacks_test/screens/profie.dart';
import 'package:slacks_test/screens/wishlist.dart';

import '../log_in/login.dart';
import '../log_in/signin.dart';

class Barnew extends StatefulWidget {
  const Barnew({Key? key}) : super(key: key);

  @override
  _BarnewState createState() => _BarnewState();
}

class _BarnewState extends State<Barnew> {
 SharedPreferences ?logindata;
String? username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata!.getString('username')!;
    });
  }
  int pageIndex = 0;

  final pages = [
    const Banner1(),
   // HomePage(),
    Categ(),
    const Cart(),
 const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async=>false ,
     child: SafeArea(
       child: Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.black,
         ),
       drawer: Drawer(
         child: ListView(
           children: [
             DrawerHeader(
               decoration: BoxDecoration(
                 color: Colors.black,
               ),
               child: CircleAvatar(
                 backgroundColor: Colors.transparent,
                 backgroundImage: NetworkImage(imageUrl!),
                 radius: 40,
               ),),
             Text(
               name!,
               style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.bold),
             ),
             // SizedBox(height: 20),
             Text(
               email!,
               style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.bold),
             ),
             SizedBox(height: 40),
             ListTile(title:Text( "$username")   ,),
             ListTile(
               title: const Text('Profile'),
               leading: Icon(
                 Icons.person,
                 color: Colors.black,
               ),
               onTap: () {
                 Navigator.push(
                     context, MaterialPageRoute(builder: (_) => Profile()));
               },
             ),
             ListTile(
               leading: Icon(
                 Icons.favorite,
                 color: Colors.black,
               ),
               title: const Text('Favourite'),
               onTap: () {},
             ),
             ListTile(
               leading: Icon(Icons.shopping_bag, color: Colors.black),
               title: const Text('Wishlist'),
               onTap: () {
                 Navigator.push(
                     context, MaterialPageRoute(builder: (_) => Wish()));
               },
             ),
             ListTile(
               leading: Icon(
                 Icons.settings,
                 color: Colors.black,
               ),
               title: const Text('settings'),
               onTap: () {},
             ),
             ListTile(
               leading: Icon(
                 Icons.shopping_cart,
                 color: Colors.black,
               ),
               title: Text('My orders'),
             ),
             ListTile(
               leading: Icon(
                 Icons.logout_outlined,
                 color: Colors.black,
               ),
               title: const Text('Log out'),
               onTap: () {
                 logindata?.setBool('login', false);
                 Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context) =>const LOG()));
               },
             ),
           ],
         ),
       ),
        backgroundColor: Colors.black,
        body: pages[pageIndex],
        bottomNavigationBar: buildMyNavBar(context),
    ),
     )
    );
  }
  Container buildMyNavBar(BuildContext context) {
    return Container(
       height: 60,
        decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.local_offer,
              color: Colors.white,
              size: 20,
            )
                : const Icon(
              Icons.local_offer_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.home,
              color: Colors.white,
              size: 20,
            )
                : const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
              size: 20,
            )
                : const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
              Icons.person,
              color: Colors.white,
              size: 20,
            )
                : const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 20,
            ),
          ),
          Text("$username",style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}

