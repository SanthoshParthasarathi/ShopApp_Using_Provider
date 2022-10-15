import 'package:flutter/material.dart';
import 'package:new_shopapp/providers_practice/datamodel.dart';
import 'package:new_shopapp/providers_practice/service.dart';

class ProviderData extends ChangeNotifier {
  DataModel? post;
  bool loading = false;

  getPostData() async {
    loading = true;
    post = (await getSinglePostData())!;
    loading = false;

    notifyListeners();
  }
}
