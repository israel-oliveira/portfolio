import 'package:flutter/material.dart';

extension AppContext on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
}
