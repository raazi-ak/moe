import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../../amplify_outputs.dart'; // Ensure this is generated from Amplify setup

class AmplifyRepository {
  Future<void> configureAmplify() async {
    try {
      final authPlugin = AmplifyAuthCognito();
      await Amplify.addPlugin(authPlugin);
      await Amplify.configure(amplifyConfig);
      safePrint('Amplify configured successfully.');
    } catch (e) {
      safePrint('Amplify configuration failed: $e');
      rethrow;
    }
  }
}
