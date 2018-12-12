package com.vpon.flutterexample;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.support.multidex.MultiDex;
import com.google.android.gms.ads.MobileAds;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    MultiDex.install(this);
    GeneratedPluginRegistrant.registerWith(this);
  }
}
