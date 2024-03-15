// To parse this JSON data, do
//
//     final lyricsResponse = lyricsResponseFromJson(jsonString);

import 'dart:convert';

LyricsResponse lyricsResponseFromJson(String str) =>
    LyricsResponse.fromJson(json.decode(str));

String lyricsResponseToJson(LyricsResponse data) => json.encode(data.toJson());

class LyricsResponse {
  Message? message;
  int? statusCode;
  String? error;
  Lyrics? lyrics;

  LyricsResponse({this.message, this.statusCode, this.error, this.lyrics});

  factory LyricsResponse.fromJson(Map<String, dynamic> json) => LyricsResponse(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class Message {
  Header? header;
  Body? body;

  Message({
    this.header,
    this.body,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        header: json["header"] == null ? null : Header.fromJson(json["header"]),
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "header": header?.toJson(),
        "body": body?.toJson(),
      };
}

class Body {
  Lyrics? lyrics;

  Body({
    this.lyrics,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        lyrics: json["lyrics"] == null ? null : Lyrics.fromJson(json["lyrics"]),
      );

  Map<String, dynamic> toJson() => {
        "lyrics": lyrics?.toJson(),
      };
}

class Lyrics {
  int? lyricsId;
  int? explicit;
  String? lyricsBody;
  String? scriptTrackingUrl;
  String? pixelTrackingUrl;
  String? lyricsCopyright;
  DateTime? updatedTime;

  Lyrics({
    this.lyricsId,
    this.explicit,
    this.lyricsBody,
    this.scriptTrackingUrl,
    this.pixelTrackingUrl,
    this.lyricsCopyright,
    this.updatedTime,
  });

  factory Lyrics.fromJson(Map<String, dynamic> json) => Lyrics(
        lyricsId: json["lyrics_id"],
        explicit: json["explicit"],
        lyricsBody: json["lyrics_body"],
        scriptTrackingUrl: json["script_tracking_url"],
        pixelTrackingUrl: json["pixel_tracking_url"],
        lyricsCopyright: json["lyrics_copyright"],
        updatedTime: json["updated_time"] == null
            ? null
            : DateTime.parse(json["updated_time"]),
      );

  Map<String, dynamic> toJson() => {
        "lyrics_id": lyricsId,
        "explicit": explicit,
        "lyrics_body": lyricsBody,
        "script_tracking_url": scriptTrackingUrl,
        "pixel_tracking_url": pixelTrackingUrl,
        "lyrics_copyright": lyricsCopyright,
        "updated_time": updatedTime?.toIso8601String(),
      };
}

class Header {
  int? statusCode;
  double? executeTime;

  Header({
    this.statusCode,
    this.executeTime,
  });

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        statusCode: json["status_code"],
        executeTime: json["execute_time"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "execute_time": executeTime,
      };
}
