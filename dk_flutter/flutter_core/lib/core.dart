library core;

import 'package:flutter/foundation.dart';


export 'src/config/app_config.dart';
export 'src/config/device_config.dart';

export 'src/log/console_log.dart';
export 'src/log/vision_log.dart';
export 'src/log/benchmark.dart';

export 'src/util/maths.dart';
export 'src/util/objects.dart';
export 'src/util/strings.dart';
export 'src/util/images.dart';
export 'src/util/utils.dart';

const bool DEBUG = kDebugMode;
const bool RELEASE = kReleaseMode;
