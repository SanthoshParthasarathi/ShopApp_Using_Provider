import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:new_shopapp/constants/global_colors.dart';
import 'package:new_shopapp/model/product_model.dart';
import 'package:new_shopapp/services/api_handler.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductModel? productModel;
  bool isError = false;
  String errorStr = "";

  Future<void> getProductDetails() async {
    try {
      productModel = await APIHandler.getProductById(id: widget.id);
    } catch (error) {
      isError = true;
      errorStr = error.toString();
      log("error $error");
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductDetails();
    super.didChangeDependencies();
  }

  final titleStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: productModel == null
          ? Container(
              child: Center(
                child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 100.0,
                    color: lightIconsColor),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const BackButton(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productModel!.category!.name.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  productModel!.title.toString(),
                                  textAlign: TextAlign.start,
                                  style: titleStyle,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: RichText(
                                  text: TextSpan(
                                    text: '\$',
                                    style: TextStyle(
                                      color: Color.fromRGBO(33, 150, 243, 1),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: productModel!.price.toString(),
                                        style: TextStyle(
                                            color: lightTextColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.4,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return FancyShimmerImage(
                              imageUrl: productModel!.images![index].toString(),
                              height: size.height * 0.2,
                              boxFit: BoxFit.fill);
                        },
                        autoplay: true,
                        itemCount: 3,
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            activeColor: Colors.deepOrange,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            "Description",
                            style: titleStyle,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            productModel!.description.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
