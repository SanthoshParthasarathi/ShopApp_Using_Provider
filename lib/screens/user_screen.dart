import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:new_shopapp/constants/global_colors.dart';
import 'package:new_shopapp/model/category_model.dart';
import 'package:new_shopapp/model/users_model.dart';
import 'package:new_shopapp/services/api_handler.dart';
import 'package:new_shopapp/widgets/category_widget.dart';
import 'package:new_shopapp/widgets/users_widget.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: APIHandler.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: UserWidget(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
