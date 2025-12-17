enum MimeType {
  // Images
  jpeg(mime: "image/jpeg", extension: "jpg"),
  png(mime: "image/png", extension: "png"),
  gif(mime: "image/gif", extension: "gif"),
  bmp(mime: "image/bmp", extension: "bmp"),
  webp(mime: "image/webp", extension: "webp"),
  svg(mime: "image/svg+xml", extension: "svg"),

  // Audio
  mp3(mime: "audio/mpeg", extension: "mp3"),
  wav(mime: "audio/wav", extension: "wav"),
  ogg(mime: "audio/ogg", extension: "ogg"),
  aac(mime: "audio/aac", extension: "aac"),
  midi(mime: "audio/midi", extension: "mid"),

  // Video
  mp4(mime: "video/mp4", extension: "mp4"),
  avi(mime: "video/x-msvideo", extension: "avi"),
  mov(mime: "video/quicktime", extension: "mov"),
  mkv(mime: "video/x-matroska", extension: "mkv"),
  webm(mime: "video/webm", extension: "webm"),

  // Documents
  pdf(mime: "application/pdf", extension: "pdf"),
  doc(mime: "application/msword", extension: "doc"),
  docx(
    mime:
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    extension: "docx",
  ),
  xls(mime: "application/vnd.ms-excel", extension: "xls"),
  xlsx(
    mime: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    extension: "xlsx",
  ),
  ppt(mime: "application/vnd.ms-powerpoint", extension: "ppt"),
  pptx(
    mime:
        "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    extension: "pptx",
  ),

  // Text
  plain(mime: "text/plain", extension: "txt"),
  html(mime: "text/html", extension: "html"),
  csv(mime: "text/csv", extension: "csv"),
  json(mime: "application/json", extension: "json"),
  xml(mime: "application/xml", extension: "xml"),

  // Archives
  zip(mime: "application/zip", extension: "zip"),
  tar(mime: "application/x-tar", extension: "tar"),
  rar(mime: "application/vnd.rar", extension: "rar"),
  gz(mime: "application/gzip", extension: "gz"),

  // Others
  apk(mime: "application/vnd.android.package-archive", extension: "apk"),
  octetStream(mime: "application/octet-stream", extension: "bin");

  final String mime;
  final String extension;

  const MimeType({required this.mime, required this.extension});
}
