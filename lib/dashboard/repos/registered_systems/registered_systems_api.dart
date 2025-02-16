import 'dart:convert';
import 'package:http/http.dart' as http;

class Registered_Systems_API_Repo{
  final String apiUrl =
      "https://240ko4d457.execute-api.eu-central-1.amazonaws.com/production/user_data";
  //SharedPreferences? prefs;

  Future<List<String>?> fetchUserSystems() async {
    // if (prefs == null) {
    //   await _initSharedPrefs(); // Ensure prefs is initialized
    // }

    // String? email = prefs?.getString('email');
    // if (email == null) {
    //   print('Error: Email not found in SharedPreferences');
    //   return null;
    // }

    try {
      // Build the full URL with the query parameter
      //final url = Uri.parse('$apiUrl?email=$email');
      final url = Uri.parse('$apiUrl?email=karansingh122134@gmail.com');

      // Send GET request to the AWS Lambda function
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      // Handle the response
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        // Extract the system or device IDs
        List<String> deviceIds = [];
        if (jsonData['registered_systems'] != null) {
          for (var system in jsonData['registered_systems']) {
            deviceIds.add(system.toString());
          }
        }
        return deviceIds; // Return the list of device IDs
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }
}