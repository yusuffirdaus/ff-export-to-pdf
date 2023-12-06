import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC_14uiU_Bl1cRUMbnpJA1xU5oVdl2vIDk",
            authDomain: "yusuf-ff-crud.firebaseapp.com",
            projectId: "yusuf-ff-crud",
            storageBucket: "yusuf-ff-crud.appspot.com",
            messagingSenderId: "439742309652",
            appId: "1:439742309652:web:2b01a37a30aa588bfc4e01",
            measurementId: "G-RBLG57RMKD"));
  } else {
    await Firebase.initializeApp();
  }
}
