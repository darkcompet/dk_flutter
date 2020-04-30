import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:kilobytes_flutter_core/core.dart' show RELEASE;

/**
 * Vision (Lon on Screen) log utility class. Some functions can be used in debug mode,
 * but some ones can be only used in release mode. To use all functions of this,
 * caller maybe need wrap with `if (kDebugMode) {}` or `if (DEBUG) {}`.
 * 
 * @author: `darkcompet` (co.vp@kilobytes.com.vn)
 */
class DkVisionLogs {
   /// Write log. Note that, we can use `stdout.writeln()` instead.
   static void _log(bool validInProduct, dynamic logType, BuildContext context, Object where, dynamic msg) {
      if (RELEASE && !validInProduct) {
         throw "Cannot use log [$logType] in release mode";
      }
      Navigator.push(context, MaterialPageRoute(
         builder: (context) => Center(
            child: SingleChildScrollView(
               child: Stack(
                  children: <Widget>[
                     // msg content
                     Align(
                        alignment: Alignment.center,
                        child: Text("${_makePrefix(where, logType)} $msg"),
                     ),
                     // button close
                     Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                           icon: Icon(Icons.close),
                           onPressed: () {
                              Navigator.pop(context);
                           },
                        ),
                     ),
                  ],
               )
            ),
         ))
      );
   }

   /// Create prefix from [where] and [logType] of log.
   static String _makePrefix(Object where, dynamic logType) {
      String prefix = where == null ? "Null" : where.toString();
      prefix = prefix.length == 0 ? "?" : prefix;
      // maybe prefix is: Instance of 'where'
      int beginIndex = prefix.indexOf("'");
      int endIndex = prefix.lastIndexOf("'");
      beginIndex = beginIndex < 0 ? 0 : min(beginIndex + 1, prefix.length - 1);
      endIndex = endIndex < 0 ? prefix.length : endIndex;
      prefix = prefix.substring(beginIndex, endIndex);
      return "_____[$logType]($prefix)~";
   }

   /// Debug log. Cannot use in release mode.
   /// Caller should use it for debug only, remove it after done job.
   static void debug(BuildContext context, Object where, dynamic msg) {
      _log(false, "DEBUG", context, where, msg);
   }

   /// Info log. Cannot use in release mode.
   /// Caller should wrap it inside `if (DEBUG)` to log general events.
   static void info(BuildContext context, Object where, dynamic msg) {
      _log(false, "INFO", context, where, msg);
   }

   /// Warn log. Can use in release mode.
   /// Caller should use it to warn mistake or action which should not be occured.
   static void warn(BuildContext context, Object where, dynamic msg) {
      _log(true, "WARN", context, where, msg);
   }

   /// Error log. Can use in release mode.
   /// Caller should use it to log error message or exception.
   static void error(BuildContext context, Object where, dynamic msg) {
      _log(true, "ERROR", context, where, msg);
   }

   /// Fatal error log. Can use in release mode.
   /// Caller should use it to log fatal error like OutOfMemory, StackOverFlow...
   static void fatal(BuildContext context, Object where, dynamic msg) {
      _log(true, "FATAL", context, where, msg);
   }
}
