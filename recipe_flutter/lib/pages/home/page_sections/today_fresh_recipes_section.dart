import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter/providers/recipes.provider.dart';
import 'package:recipe_flutter/utilities/colors.dart';

class TodayFreshRecipesSection extends StatefulWidget {
  const TodayFreshRecipesSection({super.key});

  @override
  State<TodayFreshRecipesSection> createState() =>
      _TodayFreshRecipesSectionState();
}

class _TodayFreshRecipesSectionState extends State<TodayFreshRecipesSection> {
  int? currentIndex;

  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false).providerInit();
    currentIndex = 0;
    init();
    super.initState();
  }

  void init() async {
    await Provider.of<RecipesProvider>(context, listen: false)
        .getTodayFreshRecipes();
  }

  @override
  void dispose() {
    Provider.of<RecipesProvider>(context, listen: false).providerDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesProvider>(
        builder: (context, recipesProviderObj, child) {
      return recipesProviderObj.recipeList == null
          ? CircularProgressIndicator()
          : recipesProviderObj.recipeList!.isEmpty
              ? Text("No Data Found")
              : SizedBox(
                  height: 450,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 15);
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: recipesProviderObj.recipeList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                        color: Color.fromARGB(255, 233, 234, 240),
                        child: SizedBox(
                          width: 250,
                          height: 100,
                          child: Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            onTap: () {
                                              currentIndex = index;
                                              recipesProviderObj.isPressed ==
                                                      false
                                                  ? recipesProviderObj
                                                      .isPressed = true
                                                  : recipesProviderObj
                                                      .isPressed = false;
                                              recipesProviderObj
                                                  .addToFaviourateList(
                                                      recipesProviderObj
                                                          .isPressed!,
                                                      recipesProviderObj
                                                          .recipeList![index]
                                                          .docId!);
                                            },
                                            child: recipesProviderObj
                                                        .isPressed ==
                                                    true
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: ColorApp.mainColor,
                                                  )
                                                : Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.grey,
                                                  ),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Image.network(
                                          "${recipesProviderObj.recipeList![index].image}",
                                          width: 180,
                                          height: 150,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "${recipesProviderObj.recipeList![index].category}",
                                      style: const TextStyle(
                                          color: Color(0xff1F95B3),
                                          fontSize: 13),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "${recipesProviderObj.recipeList![index].title}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        for (int x = 0;
                                            x <
                                                recipesProviderObj
                                                    .recipeList![index].rate!
                                                    .toInt();
                                            x++) ...[
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffF55A00),
                                            size: 20,
                                          )
                                        ],
                                        for (int x = 0;
                                            x <
                                                5 -
                                                    (recipesProviderObj
                                                        .recipeList![index]
                                                        .rate!
                                                        .toInt());
                                            x++) ...[
                                          Icon(
                                            Icons.star_border,
                                            color: Color(0xffF55A00),
                                            size: 20,
                                          )
                                        ],
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "${recipesProviderObj.recipeList![index].calories} calories",
                                      style:
                                          TextStyle(color: Color(0xffF55A00)),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.alarm,
                                                    size: 14,
                                                    color: Color.fromARGB(
                                                        255, 162, 164, 175),
                                                  ),
                                                ),
                                                TextSpan(
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 162, 164, 175)),
                                                  text:
                                                      "${recipesProviderObj.recipeList![index].preparation_time} mins",
                                                ),
                                              ],
                                            ),
                                          ),
                                          flex: 5,
                                        ),
                                        Expanded(
                                          child: Text(""),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.alarm,
                                                    size: 14,
                                                    color: Color.fromARGB(
                                                        255, 162, 164, 175),
                                                  ),
                                                ),
                                                TextSpan(
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 162, 164, 175)),
                                                  text:
                                                      "${recipesProviderObj.recipeList![index].serving} Serving",
                                                ),
                                              ],
                                            ),
                                          ),
                                          flex: 5,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                  ));
    });
  }
}
