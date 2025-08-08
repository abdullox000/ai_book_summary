// helpers/gemini_json.dart
String extractJsonObject(String text) {
  // Remove code fences like ```json ... ```
  var cleaned = text
      .replaceAll(RegExp(r'```json', caseSensitive: false), '')
      .replaceAll('```', '')
      .trim();

  // In case the model added prose around JSON, isolate the outermost { ... }
  final start = cleaned.indexOf('{');
  final end = cleaned.lastIndexOf('}');
  if (start == -1 || end == -1 || end <= start) {
    throw FormatException('No JSON object found in model response');
  }
  return cleaned.substring(start, end + 1);
}
