import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:new_shopapp/constants/global_colors.dart';
import 'package:new_shopapp/model/product_model.dart';
import 'package:new_shopapp/services/api_handler.dart';
import 'package:new_shopapp/widgets/appbar_icons.dart';
import 'package:new_shopapp/widgets/feedwidget.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<ProductModel> productsList = [];

  int limit = 10;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts(
      limit: limit.toString(),
    );
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getProducts();
    super.didChangeDependencies();
    // ApiHandler.getAllProducts();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        limit = limit + 10;
        // if (limit == 200) {
        //   isLimit = true;
        // }
        await getProducts();
        _isLoading = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: productsList.isEmpty
          ? Container(
              child: Center(
                child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 100.0,
                    color: lightIconsColor),
              ),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GridView.builder(
                    // controller: _scrollController,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: productsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: productsList[index],
                        child: FeedWidget(
                            // title: productsList[index].title.toString(),
                            // imageUrl: productsList[index].images![0],
                            // price: productsList[index].price ,
                            ),
                      );
                    },
                  ),
                  if (_isLoading)
                    Center(
                      child: Loading(
                          indicator: BallPulseIndicator(),
                          size: 100.0,
                          color: lightIconsColor),
                    ),
                ],
              ),
            ),
    );
  }
}
