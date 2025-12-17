# rfilesaver

Plugin to save file in ANDROID or IOS device

## Getting Started

## Minimal Sample

```dart
String? path = await Rfilesaver.saveFile(
        data: data,
        fileName: 'rfilesaver_sample',
        extension: MimeType.pdf.extension,
        mimeType: MimeTgit push -u origin main --force
ype.pdf.mime,
      );
```
The MimeType has some predefined file types and its extension

## Android Setup
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

## Note
    * For android file will be stored in download folder
    * In Ios file will be stores in application documents directory

## Used Dependencies
    permission_handler
    path_provider
    device_info_plus

