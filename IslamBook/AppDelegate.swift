//
//  AppDelegate.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let configUrl = "http://disalwow.site/api/check-clean"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        loadConfig()
        if UserDefaults.standard.object(forKey: "OnOnboarding") as? Int == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "NavigationVC")
        }
        return true
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
}

