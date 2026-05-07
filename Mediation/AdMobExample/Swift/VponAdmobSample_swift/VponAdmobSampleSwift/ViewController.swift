import GoogleMobileAds
import UIKit

// Google Mobile Ads SDK v12+ 推薦使用不帶 GAD 前綴的 Swift 原生名稱

class ViewController: UIViewController {

    // MARK: - UI Components
    private let adContainerView = UIView()
    private let actionButton = UIButton()
    private let infoLabel = UILabel()
    private let consoleTextView = UITextView()

    // MARK: - Ad Components (使用 v12+ Swift 原生名稱)
    private var bannerView: BannerView?
    private var interstitialAd: InterstitialAd?
    private var nativeAd: NativeAd?
    private var adLoader: AdLoader?

    // 這些是 AdMob 的版位 ID (由 Info.plist 變數注入)
    private var adUnitIdBanner: String {
        return Bundle.main.object(forInfoDictionaryKey: "AD_UNIT_ID_BANNER") as? String ?? "ca-app-pub-3940256099942544/2934735716"
    }
    private var adUnitIdInterstitial: String {
        return Bundle.main.object(forInfoDictionaryKey: "AD_UNIT_ID_INTERSTITIAL") as? String ?? "ca-app-pub-3940256099942544/4411468910"
    }
    private var adUnitIdNative: String {
        return Bundle.main.object(forInfoDictionaryKey: "AD_UNIT_ID_NATIVE") as? String ?? "ca-app-pub-3940256099942544/3986624511"
    }

    private var adContainerHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            infoLabel.text = "Mode: \(appName)"
            if appName.contains("SPM") {
                infoLabel.textColor = .systemOrange
            } else {
                infoLabel.textColor = .systemBlue
            }
        }
        
        logToConsole("App Ready. Swift 5 Mode (SDK v12 Optimized).")
    }

    private func setupUI() {
        view.backgroundColor = UIColor(
            red: 255 / 255,
            green: 245 / 255,
            blue: 230 / 255,
            alpha: 1.0
        )

        adContainerView.backgroundColor = .white
        adContainerView.translatesAutoresizingMaskIntoConstraints = false
        adContainerView.alpha = 0.0
        adContainerView.clipsToBounds = true
        view.addSubview(adContainerView)

        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.title = "FIRE AD"
            config.baseBackgroundColor = .systemGray4
            config.baseForegroundColor = .black
            actionButton.configuration = config
        } else {
            actionButton.setTitle("FIRE AD", for: .normal)
            actionButton.backgroundColor = .lightGray
        }

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(
            self,
            action: #selector(fireAdTapped),
            for: .touchUpInside
        )
        view.addSubview(actionButton)

        infoLabel.text = "Select format to test (SDK v12 Native Names)"
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)

        consoleTextView.backgroundColor = .black
        consoleTextView.textColor = .white
        if #available(iOS 13.0, *) {
            consoleTextView.font = .monospacedSystemFont(
                ofSize: 11,
                weight: .regular
            )
        }
        consoleTextView.isEditable = false
        consoleTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(consoleTextView)

        adContainerHeightConstraint = adContainerView.heightAnchor.constraint(
            equalToConstant: 0
        )

        NSLayoutConstraint.activate([
            adContainerView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            adContainerView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            adContainerView.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: 0.95
            ),
            adContainerHeightConstraint,

            actionButton.topAnchor.constraint(
                equalTo: adContainerView.bottomAnchor,
                constant: 10
            ),
            actionButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),

            infoLabel.topAnchor.constraint(
                equalTo: actionButton.bottomAnchor,
                constant: 8
            ),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            consoleTextView.topAnchor.constraint(
                equalTo: infoLabel.bottomAnchor,
                constant: 10
            ),
            consoleTextView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            consoleTextView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            consoleTextView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -10
            ),
        ])
    }

    @objc private func fireAdTapped() {
        let alert = UIAlertController(
            title: "Select Ad Format",
            message: nil,
            preferredStyle: .actionSheet
        )
        alert.addAction(
            UIAlertAction(title: "Banner", style: .default) { _ in
                self.requestBanner()
            }
        )
        alert.addAction(
            UIAlertAction(title: "Interstitial", style: .default) { _ in
                self.requestInterstitial()
            }
        )
        alert.addAction(
            UIAlertAction(title: "Native Ad", style: .default) { _ in
                self.requestNativeAd()
            }
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    // MARK: - Ad Requests
    private func requestBanner() {
        logToConsole("Requesting Banner...")
        let bView = BannerView(adSize: AdSizeMediumRectangle)
        bView.adUnitID = adUnitIdBanner
        bView.rootViewController = self
        bView.delegate = self
        bannerView = bView
        let request = Request()
        let extra = Extras()
        extra.additionalParameters = ["contentURL":"https://www.vpon.com"]
        request.register(extra)
        bView.load(request)
    }

    private func requestInterstitial() {
        logToConsole("Requesting Interstitial...")
        InterstitialAd.load(with: adUnitIdInterstitial, request: Request()) {
            [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                self.logToConsole(
                    "Interstitial failed: \(error.localizedDescription)"
                )
                return
            }
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
            self.logToConsole("Interstitial loaded.")
            ad?.present(from: self)
        }
    }

    private func requestNativeAd() {
        logToConsole("Requesting Native...")
        adLoader = AdLoader(
            adUnitID: adUnitIdNative,
            rootViewController: self,
            adTypes: [.native],
            options: nil
        )
        adLoader?.delegate = self
        adLoader?.load(Request())
    }

    private func setupNativeAdView(_ nativeAd: NativeAd) {
        let adView = NativeAdView()
        adView.translatesAutoresizingMaskIntoConstraints = false

        let icon = UIImageView()
        let headline = UILabel()
        let body = UILabel()
        let media = MediaView()
        let cta = UIButton(type: .system)

        headline.font = .boldSystemFont(ofSize: 16)
        body.font = .systemFont(ofSize: 14)
        body.numberOfLines = 2
        cta.backgroundColor = .systemBlue
        cta.setTitleColor(.white, for: .normal)
        cta.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)

        [icon, headline, body, media, cta].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            adView.addSubview($0)
        }

        adView.nativeAd = nativeAd
        adView.iconView = icon
        adView.headlineView = headline
        adView.bodyView = body
        adView.mediaView = media
        adView.callToActionView = cta

        (adView.headlineView as? UILabel)?.text = nativeAd.headline
        (adView.bodyView as? UILabel)?.text = nativeAd.body
        (adView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        (adView.callToActionView as? UIButton)?.setTitle(
            nativeAd.callToAction,
            for: .normal
        )
        adView.mediaView?.mediaContent = nativeAd.mediaContent

        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: adView.topAnchor, constant: 10),
            icon.leadingAnchor.constraint(equalTo: adView.leadingAnchor, constant: 10),
            icon.widthAnchor.constraint(equalToConstant: 40),
            icon.heightAnchor.constraint(equalToConstant: 40),

            headline.topAnchor.constraint(equalTo: icon.topAnchor),
            headline.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            headline.trailingAnchor.constraint(equalTo: adView.trailingAnchor, constant: -10),

            body.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 2),
            body.leadingAnchor.constraint(equalTo: headline.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: adView.trailingAnchor, constant: -10),

            media.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10),
            media.leadingAnchor.constraint(equalTo: adView.leadingAnchor),
            media.trailingAnchor.constraint(equalTo: adView.trailingAnchor),
            media.heightAnchor.constraint(equalTo: media.widthAnchor, multiplier: 9.0 / 16.0),

            cta.topAnchor.constraint(equalTo: media.bottomAnchor, constant: 10),
            cta.trailingAnchor.constraint(equalTo: adView.trailingAnchor, constant: -10),
            cta.bottomAnchor.constraint(equalTo: adView.bottomAnchor, constant: -10),
            cta.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
        ])

        adContainerView.subviews.forEach { $0.removeFromSuperview() }
        adContainerView.addSubview(adView)
        NSLayoutConstraint.activate([
            adView.topAnchor.constraint(equalTo: adContainerView.topAnchor),
            adView.bottomAnchor.constraint(equalTo: adContainerView.bottomAnchor),
            adView.leadingAnchor.constraint(equalTo: adContainerView.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: adContainerView.trailingAnchor),
        ])

        adContainerHeightConstraint.constant = 320
        UIView.animate(withDuration: 0.3) {
            self.adContainerView.alpha = 1.0
            self.view.layoutIfNeeded()
        }
    }

    private func logToConsole(_ message: String) {
        let timestamp = DateFormatter.localizedString(
            from: Date(),
            dateStyle: .none,
            timeStyle: .medium
        )
        DispatchQueue.main.async {
            self.consoleTextView.text =
                "[\(timestamp)] \(message)\n" + self.consoleTextView.text
        }
    }
}

// MARK: - Delegates
extension ViewController: BannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: BannerView) {
        logToConsole("onAdLoaded (Banner)")
        adContainerView.subviews.forEach { $0.removeFromSuperview() }
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        adContainerView.addSubview(bannerView)

        NSLayoutConstraint.activate([
            bannerView.centerXAnchor.constraint(equalTo: adContainerView.centerXAnchor),
            bannerView.centerYAnchor.constraint(equalTo: adContainerView.centerYAnchor),
        ])

        adContainerHeightConstraint.constant = 250
        UIView.animate(withDuration: 0.25) {
            self.adContainerView.alpha = 1.0
            self.view.layoutIfNeeded()
        }
    }
    func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
        logToConsole("onFailedToReceiveAd (Banner): \(error.localizedDescription)")
    }
}

extension ViewController: FullScreenContentDelegate {
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        logToConsole("onAdWillPresent (Intersitial)")
    }
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        logToConsole("onAdDismissed (Intersitial)")
        self.interstitialAd = nil
    }
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        logToConsole("onAdFailedToPresent (Intersitial) - \(error.localizedDescription)")
        self.interstitialAd = nil
    }
}

extension ViewController: NativeAdLoaderDelegate, NativeAdDelegate {
    func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        logToConsole("onAdLoaded (Native)")
        nativeAd.delegate = self
        self.nativeAd = nativeAd
        setupNativeAdView(nativeAd)
    }
    func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: Error) {
        logToConsole("onAdFailed (Native): \(error.localizedDescription)")
    }
}
