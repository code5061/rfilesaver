## 0.0.1

* initial release.

## 0.0.2

* dart sdk version downgraded. Now support from '>=3.0.0 <4.0.0'

## 0.0.3

* Process split between Android 9 and below, and Android 10 and above.

* Added support for saving files on Android 9 and below.

* Both will return 
    class SavedDetails {
    String? savedPath;
    String? contentUri;
    SavedDetails({this.savedPath, this.contentUri});
  }

* On iOS, only `savedPath` is returned. The file is stored in the application's documents directory at the given path.

* On Android, both `savedPath` and `contentUri` may be returned.