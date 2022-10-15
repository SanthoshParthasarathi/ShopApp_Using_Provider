import 'package:flutter/material.dart';
import 'package:new_shopapp/constants/global_colors.dart';
import 'package:new_shopapp/model/category_model.dart';
import 'package:new_shopapp/model/product_model.dart';
// import 'package:new_shopapp/providers_practice/firstpage.dart';
// import 'package:new_shopapp/providers_practice/provider.dart';
import 'package:new_shopapp/screens/homepage.dart';
// import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Style Innovations',
        theme: ThemeData(
          scaffoldBackgroundColor: lightScaffoldColor,
          primaryColor: lightCardColor,
          backgroundColor: lightBackgroundColor,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: lightIconsColor,
            ),
            backgroundColor: lightScaffoldColor,
            centerTitle: true,
            titleTextStyle: TextStyle(
              letterSpacing: 2,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            elevation: 0,
          ),
          iconTheme: IconThemeData(
            color: lightIconsColor,
          ),

          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black,
            selectionColor: Colors.blue,

            // selectionHandleColor: Colors.blue,
          ),

          // textTheme: TextTheme()
          // textTheme: Theme.of(context).textTheme.apply(
          //       bodyColor: Colors.black,
          //       displayColor: Colors.black,
          //     ),
          cardColor: lightCardColor,
          brightness: Brightness.light,
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: lightIconsColor,
                brightness: Brightness.light,
              ),
        ),
        home: Center(
          child: SplashScreen(
            seconds: 4,
            navigateAfterSeconds: new HomePage(),
            image: new Image.asset('assets/images/shoplogo.png'),
            backgroundColor: Colors.black,
            photoSize: 200.0,
            loadingText: Text(
              'Loading please wait...',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            loaderColor: lightIconsColor,
          ),
        ),
      ),
    );
  }
}
