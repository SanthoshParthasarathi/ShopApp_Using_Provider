import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_shopapp/constants/global_colors.dart';
import 'package:new_shopapp/model/category_model.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryModelProvider = Provider.of<CategoryModel>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              imageUrl: categoryModelProvider.image.toString(),
              height: size.width * 0.45,
              width: size.width * 0.45,
              boxFit: BoxFit.fill,
              errorWidget: Icon(
                IconlyBold.danger,
                size: 28,
                color: Colors.red,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              categoryModelProvider.name.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                backgroundColor: lightCardColor.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
