import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter/models/ad.model.dart';
import 'package:recipe_flutter/pages/home/page_sections/ads_section.dart';
import 'package:recipe_flutter/pages/home/page_sections/today_fresh_recipes_section.dart';
import 'package:recipe_flutter/pages/single_recipe_old/index.single_recipe.dart';
import 'package:recipe_flutter/utilities/colors.dart';
import 'package:recipe_flutter/providers/auth.provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ZoomDrawerController zoomDrawerController;
  List<Ad> adsList = [];

  @override
  void initState() {
    zoomDrawerController = ZoomDrawerController();
    Provider.of<AppAuthProvider>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentIndexPage = 0;
    bool pressFaviourateButton = false;
    return ZoomDrawer(
      controller: zoomDrawerController,
      menuBackgroundColor: Color(0xfff0f1f5),
      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
      mainScreenTapClose: true,
      menuScreen: Scaffold(
          body: SafeArea(
              child: Container(
        color: Color(0xfff0f1f5),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {
                    zoomDrawerController.close?.call();
                    Navigator.push(context, MaterialPageRoute(builder: (__) {
                      return SingleRecipe();
                    }));
                  },
                  leading: Icon(Icons.home),
                  title: Text("Single Page"),
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("favourite"),
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Recently Viewed"),
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Settings"),
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("About Us"),
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Help"),
                  minLeadingWidth: 0,
                ),
                Consumer<AppAuthProvider>(
                    builder: (context, appAuthProviderObj, child) {
                  return InkWell(
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text("Sign Out"),
                      minLeadingWidth: 0,
                    ),
                    onTap: () {
                      appAuthProviderObj.signOut(context);
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ))),
      mainScreen: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorApp.whiteColor,
          elevation: 0,
          leading: InkWell(
            child: Icon(
              Icons.menu,
              color: ColorApp.blackColor,
            ),
            onTap: () {
              zoomDrawerController.toggle!();
            },
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20),
            children: [
              Text(
                "Bonjour ${FirebaseAuth.instance.currentUser!.displayName}",
                style: TextStyle(color: Color(0xffBEC3CF), fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "What would you like to cook today ? ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              Row(children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xffBEC3CF),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Search for recieps',
                        hintStyle: TextStyle(color: Color(0xffBEC3CF)),
                        filled: true,
                        fillColor: Color.fromARGB(255, 238, 239, 243)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                    color: Color.fromARGB(255, 238, 239, 243),
                    child: Icon(Icons.list),
                  ),
                )
              ]),
              SizedBox(
                height: 30,
              ),
              AdsSection(),
              SizedBox(
                height: 30,
              ),
              Row(children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Today's Fresh Recipes",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 25),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Text(
                        'See All',
                        style: TextStyle(
                            color: Color(0xffF55A00),
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ))
              ]),
              SizedBox(
                height: 30,
              ),
              TodayFreshRecipesSection(),
              SizedBox(
                height: 30,
              ),
              Row(children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Recommended",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 25),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Text(
                        'See All',
                        style: TextStyle(
                            color: Color(0xffF55A00),
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ))
              ]),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                color: Color.fromARGB(255, 233, 234, 240),
                child: SizedBox(
                  width: 300,
                  height: 150,
                  child: Row(children: [
                    Image.asset(
                      "assets/images/recipes/460x533_ChickenThighs_2 copy.png",
                      width: 100,
                      height: 150,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "Breakfast",
                            style: TextStyle(
                                color: Color(0xff1F95B3), fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "French Toast with Berries",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xffF55A00),
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xffF55A00),
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xffF55A00),
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xffF55A00),
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xffF55A00),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "120 calories",
                            style: TextStyle(color: Color(0xffF55A00)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.alarm,
                                        size: 14,
                                        color:
                                            Color.fromARGB(255, 162, 164, 175),
                                      ),
                                    ),
                                    TextSpan(
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 162, 164, 175)),
                                      text: "10 mins",
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.alarm,
                                        size: 14,
                                        color:
                                            Color.fromARGB(255, 162, 164, 175),
                                      ),
                                    ),
                                    TextSpan(
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 162, 164, 175)),
                                      text: "1 Serving",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ],
          ),
        )),
      ),
      borderRadius: 24.0,
      showShadow: false,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}
