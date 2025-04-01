// // Function to save data
// import 'package:shared_preferences/shared_preferences.dart';

// void saveData(String title, String description) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString(title, description);
// }

// // Function to load and print data
// void loadData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   Set<String> keys = prefs.getKeys();

//   for (String key in keys) {
//     String? value = prefs.getString(key); // Retrieve value as a String

//     if (value != null) {
//       print('Key: $key, Value: $value');
//     } else {
//       print('Key: $key has no value or is of an unknown type');
//     }
//   }
// }
