# rfilesaver

A Flutter Plugin to save file in ANDROID or IOS device

## Getting Started

## Minimal Sample

```dart
SavedDetails savedDetails = await Rfilesaver.saveFile(
        data: data,
        fileName: "rfilesaver_sample",
        extension: MimeType.pdf.extension,
        mimeType: MimeType.pdf.mime,
        pathToSave: pathToSave,
      );
```
   * The MimeType has some predefined file types and its extension
    
   * savedDetails holds 
        String? savedPath,
        String? contentUri,
    
   * On Android, both `savedPath` and `contentUri` may be returned.

   * On iOS, only `savedPath` is returned. The file is stored in the application's documents directory at the given path.


## Android Setup
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
        android:maxSdkVersion="28" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />


## Note
    * For android file will be stored in download folder
    * In Ios file will be stores in application documents directory

## Dependencies Used
    permission_handler
    path_provider
    device_info_plus

## Support
    For any quries or issues or suggestions 5061code@gmail.com 