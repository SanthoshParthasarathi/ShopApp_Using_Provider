import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_shopapp/providers_practice/datamodel.dart';
import 'package:new_shopapp/providers_practice/provider.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class ProviderDemoScreen extends StatefulWidget {
  const ProviderDemoScreen({Key? key}) : super(key: key);

  @override
  _ProviderDemoScreenState createState() => _ProviderDemoScreenState();
}

class _ProviderDemoScreenState extends State<ProviderDemoScreen> {
  @override
  void initState() {
    super.initState();
    final postModel = Provider.of<ProviderData>(context, listen: false);
    postModel.getPostData();
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<ProviderData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: postModel.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 20),
                      child: Text(
                        postModel.post?.title ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      child: Text(postModel.post?.body ?? ""),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
