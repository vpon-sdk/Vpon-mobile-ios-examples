import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

void main() {
//  iOS
//  FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-9118969380667719~9966222884');
//  Android
  FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-9118969380667719~1214538853');
  runApp(MyApp());
}

typedef GestureTapCallback = void Function();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: Home());
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BannerAd bannerAd;
  InterstitialAd interstitialAd;
//   Use AdRequest.Builder.addTestDevice("69102B84C27E6B0385EB324C335C58DE") to get test ads on this device.
  loadBanner() {
    if (bannerAd != null) bannerAd.dispose();
    bannerAd = BannerAd(
//        iOS
//        adUnitId: 'ca-app-pub-9118969380667719/7902332178',
//        android
        adUnitId: 'ca-app-pub-9118969380667719/9455743535',
        size: AdSize.banner,
        listener: (event) {
          switch (event) {
            case MobileAdEvent.loaded:
              showBanner();
              break;
            default:
              print('banner event is $event');
              break;
          }
        });
    bannerAd.load();
  }

  loadInterstitial() {
    interstitialAd = InterstitialAd(
//      iOS
//      adUnitId: 'ca-app-pub-9118969380667719/5404817887',
//      android
      adUnitId: 'ca-app-pub-9118969380667719/1938126226',
      listener: (MobileAdEvent event) {
        switch (event) {
          case MobileAdEvent.loaded:
            showInterstitial();
            break;
          case MobileAdEvent.closed:
            disposeInterstitial();
            break;
          default:
            print("InterstitialAd event is $event");
            break;
        }
      },
    );
    interstitialAd.load();
  }

  showBanner() {
    bannerAd.show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
  }

  showInterstitial() {
    interstitialAd.show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
  }

  disposeInterstitial() {
    interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List functions = [
      buildRow('Banner', () => loadBanner()),
      buildRow('Interstitial', () => loadInterstitial())
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Vpadn SDK'),
      ),
      body: new SafeArea(
          child: new Container(
            padding: EdgeInsets.only(bottom: AdSize.banner.height.toDouble()),
            child: new ListView.builder(
                itemCount: 3,
                itemBuilder: (context, i) {
                  if (i.isOdd) return Divider();
                  final index = i ~/ 2;
                  return functions[index];
                }),
          )),
    );
  }

  Widget buildRow(String title, GestureTapCallback tap) {
    return ListTile(
        title: new Text(title), trailing: new Icon(Icons.replay), onTap: tap);
  }
}
