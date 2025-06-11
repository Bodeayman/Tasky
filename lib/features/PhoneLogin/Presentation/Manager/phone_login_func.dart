import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/core/utils/shared_prefs_service.dart';
import 'package:tasky/core/utils/url.dart';

/// Logs in a user with phone and password, and stores tokens securely.
/// Throws an [Exception] on failure.
