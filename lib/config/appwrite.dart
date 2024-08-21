import 'package:appwrite/appwrite.dart';

class Appwrite {
  // This object
  static const projectId = '66acc6e000179ecc81e2';
  static const endpoint = 'https://cloud.appwrite.io/v1';

  static const databaseId = '66b07069003e03dafcf6';
  static const collectionUsers = '66b070a40005f3efb923';
  static const collectionWorkers = '66b070c200106f778ad6';
  static const collectionBooking = '66b070e20017710a9ae5';
  static const bucketWorker = '66b0cbc90000debddef6';

  static Client client = Client();
  static late Account account;
  static late Databases databases;

  static init() {
    client
        .setEndpoint(endpoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
    account = Account(client);
    databases = Databases(client);
  }

  static String imageURL(String fileId) {
    return '$endpoint/storage/buckets/$bucketWorker/files/$fileId/view?project=$projectId';
  }
}
