# http_downloader

A simple flutter app that downloads a file from the internet using the [http](https://pub.dev/packages/http) plugin.  
It has a custom-designed progress dialog which displays the download percentage to the user leveraging the power of the [provider](https://pub.dev/packages/provider) package.  
It also has an option to open the file after download. This is down using the [open_file](https://pub.dev/packages/open_file) plugin.  

**Note:** This only works on Android at the moment. Would be glad to welcome PR for an iOS fix.

## Install the packages
```yaml
http: ^0.12.1
open_file: ^3.0.1
permission_handler: ^5.0.0+hotfix.6
provider: ^4.1.1
```

## Add manifest permissions
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

After doing this, the code should work well as expected.  
Please file an issue if you come across one.  

Made with :heart_eyes: by [Akora-IngDKB](https://github.com/Akora-IngDKB).  
Follow me on [Twitter](https://twitter.com/AkoraIng_DKB).