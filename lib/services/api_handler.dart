import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:new_shopapp/constants/api_url_const.dart';
import 'package:new_shopapp/model/category_model.dart';
import 'package:new_shopapp/model/product_model.dart';
import 'package:new_shopapp/model/users_model.dart';

// class ApiHandler {
//   static Future<List<ProductModel>> getAllProducts(
//       {required String target}) async {
//     var api_Url = "https://api.escuelajs.co/api/v1/products/$target";

//     var uri = Uri.parse(api_Url);

//     var response = await http.get(uri);

//     var data = json.decode(response.body);

//     List tempList = [];

//     for (var i in data) {
//       tempList.add(i);
//     }
//     return ProductModel.productsFromSnapshot(tempList);
//   }

//   static Future<List<CategoryModel>> getAllCategories() async {
//     var api_Url = "https://api.escuelajs.co/api/v1/categories";

//     var uri = Uri.parse(api_Url);

//     var response = await http.get(uri);

//     var data = json.decode(response.body);

//     List tempList = [];

//     for (var i in data) {
//       tempList.add(i);
//     }
//     return CategoryModel.categoryFromSnapshot(tempList);
//   }

//   static Future<List<UsersModel>> getAllUsers() async {
//     var api_Url = "https://api.escuelajs.co/api/v1/users";

//     var uri = Uri.parse(api_Url);

//     var response = await http.get(uri);

//     var data = json.decode(response.body);

//     List tempList = [];

//     for (var i in data) {
//       tempList.add(i);
//     }
//     return UsersModel.usersFromSnapshot(tempList);
//   }

//   static Future<ProductModel> getProductById({required String id}) async {
//     var api_Url = "https://api.escuelajs.co/api/v1/products/$id";

//     var uri = Uri.parse(api_Url);

//     var response = await http.get(uri);

//     var data = json.decode(response.body);

//     // List tempList = [];

//     // for (var i in data) {
//     //   tempList.add(i);
//     // }
//     return ProductModel.fromJson(data);
//   }
// }

class APIHandler {
  static Future<List<dynamic>> getData(
      {required String target, String? limit}) async {
    try {
      var uri = Uri.https(
          BASE_URL,
          "api/v1/$target",
          target == "products"
              ? {
                  "offset": "0",
                  "limit": limit,
                }
              : {});
      var response = await http.get(uri);

      // print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
        // print("V $v \n\n");
      }
      return tempList;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }

  static Future<List<ProductModel>> getAllProducts(
      {required String limit}) async {
    List temp = await getData(
      target: "products",
      limit: limit,
    );
    return ProductModel.productsFromSnapshot(temp);
  }

  static Future<List<CategoryModel>> getAllCategories() async {
    List temp = await getData(target: "categories");
    return CategoryModel.categoryFromSnapshot(temp);
  }

  static Future<List<UsersModel>> getAllUsers() async {
    List temp = await getData(target: "users");
    return UsersModel.usersFromSnapshot(temp);
  }

  static Future<ProductModel> getProductById({required String id}) async {
    try {
      var uri = Uri.https(
        BASE_URL,
        "api/v1/products/$id",
      );
      var response = await http.get(uri);

      // print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data["message"];
      }
      return ProductModel.fromJson(data);
    } catch (error) {
      log("an error occured while getting product info $error");
      throw error.toString();
    }
  }
}
