import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const projectId = '66acc6e000179ecc81e2';
  static const endPoint = 'https://cloud.appwrite.io/v1';

  ini() {
    Client client = Client();
    client
        .setEndpoint(endPoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
  }
}
