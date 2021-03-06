import 'dart:io';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/repository/notification.dart';
import 'package:flutter/material.dart';
import 'package:crowd_funding_app/Models/notification.dart';

class UserNotificationModel extends ChangeNotifier {
  UserNotificationRepository notificationRepository;
  UserNotificationModel({required this.notificationRepository});
  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  bool _deleteUpdate = false;

  // get Response
  Response get response => _response;

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future<void> getAllUserNotifications(String token) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      List<UserNotification> userNotifications =
          await notificationRepository.getUserNotifications(token);

      response = Response(
          status: ResponseStatus.SUCCESS,
          data: userNotifications,
          message: "successfully fetched notifications");
    } on SocketException catch (e) {
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      response = Response(
        status: ResponseStatus.MISMATCHERROR,
        data: null,
        message: 'failed to get notifications',
      );
    }
  }

  // update notification mark as viewed

  Future updateNotification(UserNotification notification, String token) async {
    print("updateing$notification");
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      final updateResponse =
          await notificationRepository.updateNotificationi(notification, token);
      if (updateResponse == 'updated')
        response = response = Response(
            status: ResponseStatus.SUCCESS,
            data: updateResponse,
            message: "successfully fetched notifications");
    } on SocketException catch (e) {
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      print(e.toString());
      response = Response(
        status: ResponseStatus.MISMATCHERROR,
        data: null,
        message: 'failed to update',
      );
    }
  }

  // delete noification
  Future deleteNotification(String id, String token) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      final deleteResponse =
          await notificationRepository.deleteNotification(id, token);
      if (deleteResponse == 'deleted')
        response = response = Response(
            status: ResponseStatus.SUCCESS,
            data: deleteResponse,
            message: "successfully fetched notifications");
    } on SocketException catch (e) {
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      response = Response(
        status: ResponseStatus.MISMATCHERROR,
        data: null,
        message: "failed to delete",
      );
    }
  }

  Future signOut() async {
    response =
        Response(data: null, status: ResponseStatus.LOADING, message: "");
  }
}
