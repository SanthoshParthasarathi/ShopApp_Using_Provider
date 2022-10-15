import 'package:flutter/material.dart';
import 'package:new_shopapp/model/product_model.dart';
import 'package:new_shopapp/widgets/feedwidget.dart';
import 'package:provider/provider.dart';

class FeedGridWidget extends StatelessWidget {
  const FeedGridWidget({Key? key, required this.productsList})
      : super(key: key);

  final List<ProductModel> productsList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: productsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              // price: productsList[index].price,
              ),
        );
      },
    );
  }
}
