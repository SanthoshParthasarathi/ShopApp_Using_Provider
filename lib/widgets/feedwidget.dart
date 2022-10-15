import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_shopapp/constants/global_colors.dart';
import 'package:new_shopapp/model/product_model.dart';
import 'package:new_shopapp/screens/product_details.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FeedWidget extends StatelessWidget {
  FeedWidget({
    Key? key,
    // required this.title,
    // required this.imageUrl,
    // required this.price,
  }) : super(key: key);

  // final String title;
  // final String imageUrl;
  // final int price;

  @override
  Widget build(BuildContext context) {
    final productModelProvider = Provider.of<ProductModel>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                  child: ProductDetailsScreen(
                    id: productModelProvider.id.toString(),
                  ),
                  type: PageTransitionType.fade),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: '\$',
                          style: TextStyle(
                            color: Color.fromRGBO(33, 150, 243, 1),
                          ),
                          children: [
                            TextSpan(
                              text: productModelProvider.price.toString(),
                              style: TextStyle(
                                  color: lightTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(IconlyBold.heart),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    imageUrl: productModelProvider.images![0],
                    height: size.height * 0.2,
                    boxFit: BoxFit.fill,
                    errorWidget: Icon(
                      IconlyBold.danger,
                      size: 28,
                      color: Colors.red,
                    ),
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productModelProvider.title.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
