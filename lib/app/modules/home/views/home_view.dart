import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resepapp/app/services/database.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController instructionController = TextEditingController();

  Stream<QuerySnapshot> recipeStream = DatabaseMethods().getRecipeDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 67, 24, 241),
        elevation: 5.0,
        shape: const CircleBorder(),
        onPressed: () {
          Get.toNamed(Routes.ADD_RECIPE);
        },
        child: const Icon(CupertinoIcons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 123, 74),
        title: Text(
          'ResepApp',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 30),
        child: StreamBuilder(
          stream: recipeStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No recipe available',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 67, 24, 241),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, top: 12, right: 12),
                            child: Row(
                              children: [
                                Text(
                                  data['title'],
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    EditRecipeDetail(context, data);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: const Color.fromARGB(
                                        255, 180, 177, 177),
                                  ),
                                ),
                                SizedBox(width: 9),
                                GestureDetector(
                                  onTap: () {
                                    deleteRecipe(context, data['title']);
                                  },
                                  child: Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.red[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Text(
                              data['time_estimation'] + ' Minutes',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: const Color.fromARGB(255, 67, 24, 241),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Future EditRecipeDetail(
      BuildContext context, Map<String, dynamic> data) async {
    nameController.text = data["title"];
    timeController.text = data["time_estimation"];
    ingredientController.text = data["ingredients"];
    instructionController.text = data["instruction"];

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel,
                        color: const Color.fromARGB(255, 120, 118, 118)),
                  ),
                  SizedBox(width: 60),
                  Text(
                    'Edit Recipe',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 67, 24, 241),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Text(
                'Food/Drink Name',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 350,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(13),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Time Estimation (Minute)',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: const Color.fromARGB(255, 236, 123, 74),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 350,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(13),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Ingredients',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: ingredientController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(13),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Instructions',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: const Color.fromARGB(255, 236, 123, 74),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 350,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: instructionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(13),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 67, 24, 241),
                  ),
                  onPressed: () {
                    updateRecipe(context, data['title']);
                  },
                  child: Text(
                    'Update',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateRecipe(BuildContext context, String title) async {
    String updatedName = nameController.text;
    String updatedTime = timeController.text;
    String updatedIngredients = ingredientController.text;
    String updatedInstruction = instructionController.text;

    Map<String, dynamic> updatedData = {
      "title": updatedName,
      "time_estimation": updatedTime,
      "ingredients": updatedIngredients,
      "instruction": updatedInstruction,
    };
    await DatabaseMethods().updateRecipeByTitle(title, updatedData);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recipe updated successfully'),
      ),
    );
    Navigator.pop(context);
  }

  Future<void> deleteRecipe(BuildContext context, String title) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Recipe'),
        content: Text('Are you sure you want to delete this recipe?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      try {
        await DatabaseMethods().deleteRecipe(title);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Recipe deleted successfully'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete recipe: $e'),
          ),
        );
      }
    }
  }
}
