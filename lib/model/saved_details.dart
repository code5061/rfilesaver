import 'dart:convert';

class SavedDetails {
  String? savedPath;
  String? contentUri;
  SavedDetails({this.savedPath, this.contentUri});

  SavedDetails copyWith({String? savedPath, String? contentUri}) {
    return SavedDetails(
      savedPath: savedPath ?? this.savedPath,
      contentUri: contentUri ?? this.contentUri,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (savedPath != null) {
      result.addAll({'savedPath': savedPath});
    }
    if (contentUri != null) {
      result.addAll({'contentUri': contentUri});
    }

    return result;
  }

  factory SavedDetails.fromMap(Map<String, dynamic> map) {
    return SavedDetails(
      savedPath: map['savedPath'],
      contentUri: map['contentUri'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SavedDetails.fromJson(String source) =>
      SavedDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'SavedDetails(savedPath: $savedPath, contentUri: $contentUri)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SavedDetails &&
        other.savedPath == savedPath &&
        other.contentUri == contentUri;
  }

  @override
  int get hashCode => savedPath.hashCode ^ contentUri.hashCode;
}
