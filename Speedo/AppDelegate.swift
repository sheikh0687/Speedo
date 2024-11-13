
//
//  AppDelegate.swift
//  Speedo
//
//  Created by mac on 17/04/21.
//

import UIKit
import MapKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate , MessagingDelegate {

    var window: UIWindow?
    var CURRENT_LAT = ""
    var CURRENT_LON = ""
    var isValidLocation:Bool = true
    var coordinate1 = CLLocation(latitude: 0.0, longitude: 0.0)
    var coordinate2 = CLLocation(latitude: 0.0, longitude: 0.0)
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        notificationCenter.delegate = self
        self.configureNotification()
        
        if k.userDefault.value(forKey: k.session.language) == nil {
            print("language not set")
            k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
            L102Language.setAppleLAnguageTo(lang: "en")
        }
        
        L102Localizer.DoTheMagic()
        LocationManager.sharedInstance.delegate = kAppDelegate
        LocationManager.sharedInstance.startUpdatingLocation()
        Switcher.updateRootVC()
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = R.color.theme_color()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

extension AppDelegate: LocationManagerDelegate {
    
    func didEnterInCircularArea() {
        print("")
    }
    
    func didExitCircularArea() {
        print("")
    }
 
    func tracingLocation(currentLocation: CLLocation) {
        coordinate2 = currentLocation
        print(coordinate2)
        let distanceInMeters = coordinate1.distance(from: coordinate2) // result is in meters
        if distanceInMeters > 250 {
            CURRENT_LAT = String(currentLocation.coordinate.latitude)
            CURRENT_LON = String(currentLocation.coordinate.longitude)
            coordinate1 = currentLocation
            if let _ = UserDefaults.standard.value(forKey: "user_id") {
                //self.updateLatLon()
            }
        }
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}

extension AppDelegate {
    
    func configureNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        }
        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                k.iosRegisterId = token
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        k.iosRegisterId = deviceTokenString
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
    }
    
    // MARK:-  Received Remote Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject> {
            print(info)
         
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
//        self.redirectNotification()
        completionHandler()
    }
    
    func redirectNotification() {
//        if let info = userInfo["aps"] as? Dictionary<String, AnyObject> {
//            let status = userInfo["gcm.notification.ios_status"] as? String
//            print("Status Notification: ",status)
//        }
    }
}

//extension AppDelegate: LocationManagerDelegate {
//
//    func tracingLocation(currentLocation: CLLocation) {
//        coordinate2 = currentLocation
//        let distanceInMeters = coordinate1.distance(from: coordinate2) // result is in meters
//        if distanceInMeters > 250 {
//            CURRENT_LAT = String(currentLocation.coordinate.latitude)
//            CURRENT_LON = String(currentLocation.coordinate.longitude)
//            coordinate1 = currentLocation
//            if let _ = UserDefaults.standard.value(forKey: "user_id") {
//                //self.updateLatLon()
//            }
//        }
//    }
//
//    func tracingLocationDidFailWithError(error: NSError) {
//        print("tracing Location Error : \(error.description)")
//    }
//}
