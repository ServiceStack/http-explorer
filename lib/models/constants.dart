import 'package:flutter/material.dart';

class AppStyles {
  static final appMessageTextColor = Colors.grey.shade500;
  static final errorTextColor = Colors.red.shade700;
  static Text getMessageLabel(String msg) =>
      Text(msg, style: const TextStyle(fontSize: 20));
  static Text getErrorLabel(String errorMsg) =>
      Text(errorMsg, style: TextStyle(color: AppStyles.errorTextColor, fontSize: 20));
}

class HttpMethods {
  static const String Get = "GET";
  static const String Post = "POST";
  static const String Put = "PUT";
  static const String Delete = "DELETE";
  static const String Patch = "PATCH";
  static const String Head = "HEAD";
  static const String Options = "OPTIONS";
}

