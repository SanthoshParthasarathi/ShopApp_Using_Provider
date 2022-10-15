import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_shopapp/constants/global_colors.dart';
import 'package:new_shopapp/model/users_model.dart';
import 'package:provider/provider.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModelProvider = Provider.of<UsersModel>(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
        imageUrl: userModelProvider.avatar.toString(),
        height: size.width * 0.15,
        boxFit: BoxFit.fill,
        errorWidget: Icon(
          IconlyBold.danger,
          size: 28,
          color: Colors.red,
        ),
        width: size.width * 0.15,
      ),
      title: Text(userModelProvider.name.toString()),
      subtitle: Text(userModelProvider.email.toString()),
      trailing: Text(
        userModelProvider.role.toString(),
        style: TextStyle(
          color: lightIconsColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
