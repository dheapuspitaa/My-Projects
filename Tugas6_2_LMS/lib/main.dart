import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyB7FxbxMzZFqi31vYtcTI0KDIdveLcU2XQ",
      appId: "1:647397169075:android:4ac79b892fdf2345e3ddc6",
      messagingSenderId: "647397169075",
      projectId: "resepapp-8f01a",
    ),
  );
  runApp(
    GetMaterialApp(
      title: "ResepApp",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
