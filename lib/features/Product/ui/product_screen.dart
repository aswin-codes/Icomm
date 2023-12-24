import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icomm/data/product_screen_data.dart';
import 'package:icomm/features/Product/bloc/product_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductBloc productBloc = ProductBloc();
  int imageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    productBloc.add(ProductInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      bloc: productBloc,
      listenWhen: (previous, current) => current is ProductActionState,
      buildWhen: (previus, current) => current is! ProductActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProductInitial:
            return Scaffold(
                //extendBodyBehindAppBar: true,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  actions: const [
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          CupertinoIcons.heart,
                          color: Colors.black,
                        ))
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          onPageChanged: (_) {
                            setState(() {
                              imageIndex = _;
                            });
                          },
                          itemCount: productData.imageUrl.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: "image",
                              child: Image.network(
                                productData.imageUrl[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 10,
                                  width: 10,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: imageIndex == 0
                                          ? Colors.grey
                                          : Colors.grey[300])),
                              Container(
                                  height: 10,
                                  width: 10,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: imageIndex == 1
                                          ? Colors.grey
                                          : Colors.grey[300])),
                              Container(
                                  height: 10,
                                  width: 10,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: imageIndex == 2
                                          ? Colors.grey
                                          : Colors.grey[300])),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            productData.name,
                            style: GoogleFonts.roboto(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 23,
                                fontWeight: FontWeight.w600),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            productData.category.categoryName,
                            style: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            "\$ ${productData.price}",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            "Description",
                            style: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 5, right: 10),
                          child: Text(
                            productData.description,
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          )),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "Add to Cart",
                                style: GoogleFonts.roboto(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25)),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "Buy Now",
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ));
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
