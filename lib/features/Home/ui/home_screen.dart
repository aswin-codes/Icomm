import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icomm/data/home_screen_data.dart';
import 'package:icomm/features/Home/bloc/home_bloc.dart';
import 'package:icomm/features/Home/model/category_model.dart';
import 'package:icomm/features/Home/model/product_model.dart';
import 'package:icomm/features/Home/ui/home_loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is LogOutButtonClickedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/splash', (route) => false);
        }
      },
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return HomeLoadingScreen();
          case HomeSuccessfullyFetchedProductsState:
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
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
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
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25),
                ),
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Discover new products",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 18,
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
                            itemCount: categoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              CategoryModel category = categoryList[index];
                              return Padding(
                                padding: ((index == 0) ||
                                        (index == categoryList.length - 1))
                                    ? EdgeInsets.zero
                                    : EdgeInsets.symmetric(horizontal: 10),
                                child: Chip(
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.circular(70)),
                                  label: Text(
                                    category.categoryName,
                                    style: GoogleFonts.roboto(
                                        color: category.isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15),
                                  ),
                                  color: category.isSelected
                                      ? MaterialStateProperty.all(Colors.black)
                                      : MaterialStateProperty.all(
                                          Colors.grey.shade300),
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProductModel product = productList[index];
                            return Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[500],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.network(
                                        product.imageUrl[0].toString(),
                                        fit: BoxFit
                                            .cover, // This ensures that the image covers the entire space
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, bottom: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(product.name.length > 15
                                                ? "${product.name.substring(0, 15)}..."
                                                : product.name),
                                            Text(
                                              "\$ ${product.price}",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10))),
                                        child: const Icon(
                                          Icons.add_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25)),
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

          default:
            return const Scaffold(
              body: Center(
                child:
                    Text("Sorry, something went wrong. Please try again later"),
              ),
            );
        }
      },
    );
  }
}
