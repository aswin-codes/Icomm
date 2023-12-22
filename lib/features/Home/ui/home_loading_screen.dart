import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icomm/data/home_screen_data.dart';
import 'package:icomm/features/Home/model/category_model.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingScreen extends StatefulWidget {
  const HomeLoadingScreen({super.key});

  @override
  State<HomeLoadingScreen> createState() => _HomeLoadingScreenState();
}

class _HomeLoadingScreenState extends State<HomeLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                // Handle menu item selection
                if (value == "logout") {}
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  userName[0],
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
                // Add more PopupMenuItems as needed
              ],
            ),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Icomm",
          style: GoogleFonts.kanit(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[500]!,
                highlightColor: Colors.grey[300]!,
                child: Text(
                  "Discover new products",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      //CategoryModel category = categoryList[index];
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          padding: const EdgeInsets.all(8)),
                    );
                  })
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("assets/images/home.png"),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Home",
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/search.png",
                  height: 20,
                ),
                Image.asset(
                  "assets/images/favourite.png",
                  height: 20,
                ),
                Image.asset(
                  "assets/images/cart.png",
                  height: 20,
                ),
                Image.asset(
                  "assets/images/user.png",
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
