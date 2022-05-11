//
//  ViewController.swift
//  tenjin-ios-sdk-swift
//
//  Copyright © 2018 Tenjin. All rights reserved.
//

import UIKit
import AppTrackingTransparency
import AdSupport
import AppLovinSDK

class ViewController: UIViewController, MAAdViewAdDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // In
        TenjinSDK.getInstance("YWZKFWDZEREQCFMF3DST3AYHZPCC9MWV")
        TenjinSDK.appendAppSubversion(6789)
        if #available(iOS 14, *) {
            // Displaying an ATT permission prompt
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                case .authorized:
                    print("Authorized")
                    print("Granted consent")
                    // Tenjin initialization with ATTrackingManager
                    TenjinSDK.connect()
                    self.appLovinILRDImplement()
                case .denied:
                    print("Denied")
                    print("Denied consent")
                case .notDetermined:
                    print("Not Determined")
                    print("Unknown consent")
                case .restricted:
                    print("Restricted")
                    print("Device has an MDM solution applied")
                @unknown default:
                    print("Unknown")
                
                }
            }
        } else {
            TenjinSDK.connect()
            self.appLovinILRDImplement()
        }
    }
    
    func appLovinILRDImplement() {
        // AppLovin Impression Level Ad Revenue Integration
        TenjinSDK.subscribeAppLovinImpressions()
        // AppLovin MAX SDK
        ALSdk.shared()!.mediationProvider = "max"
        ALSdk.shared()!.userIdentifier = "USER_ID"
        ALSdk.shared()!.initializeSdk { (configuration: ALSdkConfiguration) in
            // Start loading ads
            self.createBannerAd()
        }
    }
    
    var adView: MAAdView!
    
    func createBannerAd()
    {
        self.adView = MAAdView(adUnitIdentifier: "49d9923bb879cc4f")
        self.adView.delegate = self
        // Banner height on iPhone and iPad is 50 and 90, respectively
        let height: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ? 90 : 50
        // Stretch to the width of the screen for banners to be fully functional
        let width: CGFloat = UIScreen.main.bounds.width
    
        self.adView.frame = CGRect(x: 0, y: 50, width: width, height: height)
        // Set background or background color for banners to be fully functional
        self.adView.backgroundColor = UIColor.black
    
        view.addSubview(adView)
        // Load the first ad
        self.adView.loadAd()
    }
    
    // MARK: MAAdDelegate Protocol
    func didLoad(_ ad: MAAd) {}
    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {}
    func didClick(_ ad: MAAd) {}
    func didFail(toDisplay ad: MAAd, withError error: MAError) {}

    // MARK: MAAdViewAdDelegate Protocol
    func didExpand(_ ad: MAAd) {}
    func didCollapse(_ ad: MAAd) {}

    // MARK: Deprecated Callbacks
    func didDisplay(_ ad: MAAd) { /* DO NOT USE - THIS IS RESERVED FOR FULLSCREEN ADS ONLY AND WILL BE REMOVED IN A FUTURE SDK RELEASE */ }
    func didHide(_ ad: MAAd) { /* DO NOT USE - THIS IS RESERVED FOR FULLSCREEN ADS ONLY AND WILL BE REMOVED IN A FUTURE SDK RELEASE */ }
}

