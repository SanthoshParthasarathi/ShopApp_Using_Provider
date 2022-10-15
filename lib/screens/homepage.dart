import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:new_shopapp/constants/global_colors.dart';
import 'package:new_shopapp/model/product_model.dart';
import 'package:new_shopapp/screens/categoryscreen.dart';
import 'package:new_shopapp/screens/feedscreen.dart';
import 'package:new_shopapp/screens/user_screen.dart';
import 'package:new_shopapp/services/api_handler.dart';
import 'package:new_shopapp/widgets/appbar_icons.dart';
import 'package:new_shopapp/widgets/feeds_grid_widget.dart';
import 'package:new_shopapp/widgets/feedwidget.dart';
import 'package:new_shopapp/widgets/sale_widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? _textEditingController;

  List<ProductModel> productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController!.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   getProducts();
  //   super.didChangeDependencies();
  //   // ApiHandler.getAllProducts();
  // }

  // Future<void> getProducts() async {
  //   productList = await APIHandler.getAllProducts();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('BOLT GARMENTS'),
          leading: AppBarIcons(
            function: () {
              Navigator.push(
                context,
                PageTransition(
                    child: CategoriesScreen(), type: PageTransitionType.fade),
              );
            },
            icon: IconlyBold.category,
          ),
          actions: [
            AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: UsersScreen(), type: PageTransitionType.fade),
                );
              },
              icon: IconlyBold.user3,
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).cardColor,
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.25,
                      child: Swiper(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return const SaleWidget();
                        },
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            activeColor: Colors.deepOrange,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            'All Products',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          AppBarIcons(
                            function: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: FeedsScreen(),
                                    type: PageTransitionType.fade),
                              );
                            },
                            icon: IconlyBold.arrowRight2,
                          ),
                        ],
                      ),
                    ),
                    //// another method to get data from api using future builder
                    FutureBuilder<List<ProductModel>>(
                      future: APIHandler.getAllProducts(limit: "3"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Center(
                              child: Loading(
                                  indicator: BallPulseIndicator(),
                                  size: 100.0,
                                  color: lightIconsColor),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('An Error Occured ${snapshot.error}'),
                          );
                        } else if (snapshot.data == null) {
                          return Center(
                            child: Text('No products has been added'),
                          );
                        } else {
                          return FeedGridWidget(productsList: snapshot.data!);
                        }
                      },
                    ),
// uncomment didchangedependencies to use this below code and comment future builder

                    // productList.isEmpty
                    //     ? Container(
                    //         child: Center(
                    //           child: Loading(
                    //               indicator: BallPulseIndicator(),
                    //               size: 100.0,
                    //               color: lightIconsColor),
                    //         ),
                    //       )
                    //     : FeedGridWidget(
                    //         productsList: productList,
                    //       ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
