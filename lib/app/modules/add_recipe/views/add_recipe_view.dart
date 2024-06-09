import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/database.dart';
import '../controllers/add_recipe_controller.dart';

// ignore: must_be_immutable
class AddRecipeView extends GetView<AddRecipeController> {
  AddRecipeView({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController instructionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 123, 74),
        title: Text(
          'New Recipe',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 35, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food/Drink Name',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
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
                    fontWeight: FontWeight.bold,
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
                    fontWeight: FontWeight.bold,
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
                    fontWeight: FontWeight.bold,
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
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 45, right: 45),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 138, 107, 239),
                        backgroundColor: const Color.fromARGB(255, 67, 24, 241),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minimumSize: const Size(300, 40),
                      ),
                      onPressed: () async {
                        Map<String, dynamic> recipeInfoMap = {
                          "time_estimation": timeController.text,
                          "title": nameController.text,
                          "ingredients": ingredientController.text,
                          "instruction": instructionController.text,
                        };
                        await DatabaseMethods()
                            .addRecipeDetails(recipeInfoMap)
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "New recipe has been added",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor:
                                  const Color.fromARGB(255, 67, 24, 241),
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                      child: Text(
                        'Add Recipe',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
