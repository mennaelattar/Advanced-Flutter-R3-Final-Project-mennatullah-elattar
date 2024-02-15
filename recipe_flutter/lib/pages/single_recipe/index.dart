import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SingleRecipePage extends StatefulWidget {
  String? recipeId;
  SingleRecipePage({super.key, this.recipeId});

  @override
  State<SingleRecipePage> createState() => _SingleRecipePageState();
}

class _SingleRecipePageState extends State<SingleRecipePage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    var data = await FirebaseFirestore.instance
        .collection('recipes')
        .doc(widget.recipeId)
        .get();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//Text('${widget.recipeId}')
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Recipe Name ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 25),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "2s0 calories",
                      style: TextStyle(color: Color(0xffF55A00)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
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
                                    color: Color.fromARGB(255, 162, 164, 175),
                                  ),
                                ),
                                TextSpan(
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 162, 164, 175)),
                                  text: "6 mins",
                                ),
                              ],
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.dining_sharp,
                                    size: 14,
                                    color: Color.fromARGB(255, 162, 164, 175),
                                  ),
                                ),
                                TextSpan(
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 162, 164, 175)),
                                  text: "7 Serving",
                                ),
                              ],
                            ),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
