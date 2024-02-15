import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter/providers/ingredient.provider.dart';

class SingleRecipe extends StatefulWidget {
  const SingleRecipe({super.key});

  @override
  State<SingleRecipe> createState() => _SingleRecipeState();
}

class _SingleRecipeState extends State<SingleRecipe> {
  @override
  void initState() {
    Provider.of<IngredientsProvider>(context, listen: false).getIngredients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<IngredientsProvider>(
          builder: (context, ingredientsProviderObj, child) {
            return ingredientsProviderObj.ingredientList == null
                ? CircularProgressIndicator()
                : ingredientsProviderObj.ingredientList!.isEmpty
                    ? Text("No Data Found")
                    : ListView.builder(
                        itemCount:
                            ingredientsProviderObj.ingredientList!.length,
                        itemBuilder: (context, index) {
                          ListTile(
                            leading: Checkbox(
                              value: ingredientsProviderObj
                                  .ingredientList![index].user_ids
                                  ?.contains(
                                      FirebaseAuth.instance.currentUser?.uid),
                              onChanged: (value) =>
                                  ingredientsProviderObj.addIngredientToUser(
                                      ingredientsProviderObj
                                          .ingredientList![index].docId!,
                                      value ?? false),
                            ),
                            title: Text(
                              ingredientsProviderObj
                                      .ingredientList![index].name ??
                                  'No Name',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        });
          },
        ),
      ),
    );
  }
}
