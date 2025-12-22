package com.jar5061.rfilesaver;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import androidx.annotation.NonNull;
import java.io.IOException;
import java.io.OutputStream;
// import java.net.URI;
import java.util.HashMap;
import java.util.Map;
import java.io.FileOutputStream;
import android.os.Build;
import androidx.annotation.NonNull;
import java.io.File;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class RfilesaverPlugin implements FlutterPlugin, MethodCallHandler {

  private MethodChannel channel;
  private FlutterPluginBinding flutterPluginBinding;
  private final String chnlSvFile = "saveFile";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "rfilesaver");
    this.flutterPluginBinding = flutterPluginBinding;
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals(chnlSvFile)) {

      byte[] data = call.argument("data");
      String fileName = call.argument("fileName");
      String mimeType = call.argument("mimeType");
      String pathToSave = call.argument("pathToSave");
      Map<String, String> path = saveFileToDownloads(data, fileName, mimeType,
          flutterPluginBinding.getApplicationContext(),
          pathToSave);

      if (path != null) {
        result.success(path); // return the saved path
      } else {
        result.error("SAVE_FAILED", "Could not save file", null);
      }
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  private Map<String, String> saveFileToDownloads(byte[] data, String fileName, String mimeType, Context context,
      String pathToSave) {

    String savedPath = null, contentUri = null;

    ContentResolver resolver = context.getContentResolver();
    ContentValues values = new ContentValues();
    values.put(MediaStore.MediaColumns.DISPLAY_NAME, fileName);
    values.put(MediaStore.MediaColumns.MIME_TYPE, mimeType);

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {

      String downloadPath = Environment.DIRECTORY_DOWNLOADS;
      if (null != pathToSave && !pathToSave.trim().isBlank()) {
        downloadPath = downloadPath + "/" + pathToSave + "/";
      }

      values.put(MediaStore.MediaColumns.RELATIVE_PATH, downloadPath);
      Uri uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values);

      if (uri == null) {
        return null;
      }

      try (OutputStream out = resolver.openOutputStream(uri)) {
        out.write(data);
        out.flush();
      } catch (IOException e) {
        e.printStackTrace();
        return null;
      }

      contentUri = uri.toString();

      Cursor cursor = resolver.query(uri,
          new String[] {
              MediaStore.MediaColumns.DISPLAY_NAME,
              MediaStore.MediaColumns.RELATIVE_PATH
          },
          null, null, null);

      if (cursor != null && cursor.moveToFirst()) {
        String name = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.MediaColumns.DISPLAY_NAME));
        String relPath = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.MediaColumns.RELATIVE_PATH));

        savedPath = Environment.getExternalStorageDirectory().getAbsolutePath() + "/" + relPath + name;

        cursor.close();
      }

    } else {

      File downloads = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
      if (!downloads.exists()) {
        downloads.mkdirs();
      }

      if (null != pathToSave && !pathToSave.trim().isBlank()) {
        fileName = "/" + pathToSave + "/"+fileName;
      }

      File file = new File(downloads, fileName);

      File parentDir = file.getParentFile();
      if (parentDir != null && !parentDir.exists()) {
        parentDir.mkdirs();
      }

      try (OutputStream out = new FileOutputStream(file)) {
        out.write(data);
        out.flush();
      } catch (IOException e) {
        e.printStackTrace();
        return null;
      }

      values.put(MediaStore.MediaColumns.DATA, file.getAbsolutePath()); // absolute path
      values.put(MediaStore.MediaColumns.DISPLAY_NAME,
          file.getName());
      values.put(MediaStore.MediaColumns.MIME_TYPE,
          mimeType);

      Uri cUri = resolver.insert(MediaStore.Files.getContentUri("external"),
          values);

      if(null!=cUri){
        Cursor cursor = resolver.query(cUri, new String[] { MediaStore.MediaColumns.DATA }, null, null,
                null);

        if (cursor != null) {
          if (cursor.moveToFirst()) {
            int columnIndex = cursor.getColumnIndexOrThrow(MediaStore.MediaColumns.DATA);
            savedPath = cursor.getString(columnIndex);
          }
          cursor.close();
        }
      }

      contentUri = cUri.toString();

    }
    Map<String, String> map = new HashMap<>();
    map.put("savedPath", savedPath);
    map.put("contentUri", contentUri);
    return map;
  }

}
