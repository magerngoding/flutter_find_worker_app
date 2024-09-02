import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_coworkers_app/config/app_log.dart';
import 'package:flutter_coworkers_app/config/appwrite.dart';

import '../models/booking_model.dart';

class BookingDatasource {
  static Future<Either<String, BookingModel>> checkout(
    BookingModel bookingDetail,
  ) async {
    try {
      final response = await Appwrite.databases.createDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionBooking,
        documentId: ID.unique(),
        data: bookingDetail.toJsonRequest(),
      );

      await Appwrite.databases.updateDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        documentId: bookingDetail.workerId,
        data: {'status': 'Booked'},
      );

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Booking - checkout',
      );

      return Right(BookingModel.fromJson(response.data));
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'Booking - checkout',
      );

      String defaulMessage = 'Terjadi suatu masalah';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }

  static Future<Either<String, BookingModel>> checkHireBy(
    String workerId,
  ) async {
    try {
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionBooking,
        queries: [
          Query.equal('worker_id', workerId),
          Query.equal('status', 'In Progress'),
          Query.orderDesc('\$updatedAt'),
        ],
      );

      if (response.total < 1) {
        // available
        AppLog.error(
          body: 'Not Found',
          title: 'Booking - checkHireBy',
        );
        return const Left('Tidak ditemukan');
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Booking - checkHireBy',
      );

      BookingModel booking =
          BookingModel.fromJson(response.documents.first.data);
      return Right(booking);
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'Booking - checkHireBy',
      );

      String defaulMessage = 'Terjadi suatu masalah';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }
}
