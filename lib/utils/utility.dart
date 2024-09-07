import 'dart:math' show Random;

import 'package:copycat_base/common/logging.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/v4.dart';

const _uuid4 = UuidV4();

/// Generates a random UUID.
String getId() => _uuid4.generate();

DateTime now() {
  return DateTime.now();
}

DateTime nowUTC() {
  return DateTime.now().toUtc();
}

final _random = Random();
int getRandomIndex(int max) {
  return _random.nextInt(max);
}

Future<String> getPersistedRootDirPath([String? root]) async {
  final docDir = await getApplicationDocumentsDirectory();
  final dirPath = p.join(docDir.path, "offline", root);
  await createDirectoryIfNotExists(dirPath);
  return dirPath;
}

Future<void> clearPersistedRootDirPath([String? root]) async {
  final dirPath = await getPersistedRootDirPath(root);
  final dir = Directory(dirPath);
  try {
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  } catch (e) {
    logger.e(
      "Couldn't delete directory from cache storage.",
      error: e,
    );
  }
}

Future<void> createDirectoryIfNotExists(String path) async {
  final dir = Directory(path);
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
}

Future<void> deleteTempFile(File file) async {
  try {
    await file.delete();
  } catch (e) {
    logger.e(
      "Couldn't delete file from temp storage.",
      error: e,
    );
  }
}

Future<void> clearPersistedRootDir() async {
  try {
    final docDir = await getApplicationDocumentsDirectory();
    final dirPath = p.join(docDir.path, "offline");
    final dir = Directory(dirPath);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  } catch (e) {
    logger.e(e);
  }
}

bool get isAnalyticsSupported =>
    Platform.isAndroid || Platform.isIOS || Platform.isMacOS;

String formatBytes(int sizeInBytes, {bool precise = true}) {
  const mb = 1024 * 1024;
  const gb = mb * 1024;
  if (sizeInBytes < 1024) {
    return '$sizeInBytes b';
  } else if (sizeInBytes < gb) {
    return '${(sizeInBytes / mb).toStringAsFixed(precise ? 2 : 0)} MB';
  } else {
    return '${(sizeInBytes / gb).toStringAsFixed(precise ? 2 : 0)} GB';
  }
}

// Text cleanup
String? cleanUpString(String? input) {
  if (input == null) return null;
  // Problematic characters to be replaced them with an empty string

  final problematicCharacters = [
    '\u0000', // Null character
    '\uFFFD', // Replacement character
    '\uFEFF', // Byte Order Mark (BOM)
    '\u00A0', // Non-breaking space
    '\u00AD', // Soft hyphen
    '\u200B', // Zero width space
  ];

  String cleanedString = input;

  for (var char in problematicCharacters) {
    cleanedString = cleanedString.replaceAll(char, '');
  }

  // Remove other control characters (U+0001 to U+001F, U+007F)
  cleanedString = cleanedString.replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '');

  return cleanedString;
}

final isDesktopPlatform =
    Platform.isLinux || Platform.isMacOS || Platform.isWindows;

final isApplePlatform = Platform.isIOS || Platform.isMacOS;

final isMobilePlatform = Platform.isIOS || Platform.isAndroid;
