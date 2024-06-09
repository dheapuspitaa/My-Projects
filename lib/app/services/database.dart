import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRecipeDetails(Map<String, dynamic> recipeInfoMap) async {
    await _firestore.collection("resep").add(recipeInfoMap);
  }

  Stream<QuerySnapshot> getRecipeDetails() {
    return _firestore.collection("resep").snapshots();
  }

  Future<void> updateRecipeByTitle(
      String title, Map<String, dynamic> updatedData) async {
    CollectionReference recipesRef = _firestore.collection("resep");
    QuerySnapshot querySnapshot =
        await recipesRef.where("title", isEqualTo: title).get();
    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.update(updatedData);
      }
    } else {
      print("No recipes found with title: $title");
    }
  }

  Future<void> deleteRecipe(String title) async {
    try {
      CollectionReference recipesRef = _firestore.collection("resep");
      QuerySnapshot querySnapshot =
          await recipesRef.where("title", isEqualTo: title).get();
      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          await documentSnapshot.reference.delete();
        }
      } else {
        print("No recipes found with title: $title");
      }
    } catch (e) {
      throw Exception("Failed to delete recipe: $e");
    }
  }
}
