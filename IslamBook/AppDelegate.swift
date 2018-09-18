//
//  AppDelegate.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import AppsFlyerLib
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import FacebookShare

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerTrackerDelegate {

    var window: UIWindow?

    let configUrl = "http://islam-books.site/api/check-clean"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AppsFlyerTracker.shared().appsFlyerDevKey = "ij9E8xjzQ8CnqQu9WWvYfM"
        AppsFlyerTracker.shared().appleAppID = "1434539304"
        AppsFlyerTracker.shared().delegate = self
        //AppsFlyerTracker.shared().isDebug = true
        
        loadConfig()
        if UserDefaults.standard.object(forKey: "OnOnboarding") as? Int == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "NavigationVC")
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }
    
    func loadConfig() {
        var request = URLRequest(url: URL(string: configUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json" , forHTTPHeaderField: "Content-Type")
        let bundleID = Bundle.main.bundleIdentifier
        let params = ["package": bundleID]
        let postData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        request.httpBody = postData
        let userDefaults = UserDefaults.standard
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            do {
                guard let data = data,
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let show = json["can_show"] as? Bool,
                    show == true else {
                        userDefaults.set(false , forKey: "check")
                        userDefaults.synchronize()
                        return
                }
                userDefaults.set(true , forKey: "check")
                userDefaults.synchronize()
            } catch {
                userDefaults.set(false , forKey: "check")
                userDefaults.synchronize()
            }
            }.resume()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        storage.save()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Track Installs, updates & sessions(app opens) (You must include this API to enable tracking)
        AppEventsLogger.activate(application)
        AppsFlyerTracker.shared().trackAppLaunch()
    }
}

