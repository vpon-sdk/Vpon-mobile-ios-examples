//
//  SceneDelegate.swift
//  VponAdmobSampleSwift
//
//  iOS 27 起，以新版 SDK 建置的 App 必須採用 UIScene 生命週期；
//  window 改在這裡建立（原本在 AppDelegate）。SDK 與 Google Mobile Ads 的初始化仍在 AppDelegate。
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        window.makeKeyAndVisible()
        self.window = window
    }
}
