//
//  AppDelegate.swift
//  DemoCtStoryBoard
//
//  Created by Prajwal Jagadeesh on 07/01/24.
//

import UIKit
import CoreData
import CleverTapSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        CleverTap.autoIntegrate()
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        registerForPush()
        registerCategory()
        
        return true
    }
    
    func registerForPush() {
        // Register for Push notifications
        UNUserNotificationCenter.current().delegate = self
        // request Permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: {granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        })
    }
    
    func registerCategory(){
        let action1 = UNNotificationAction(identifier: "action_1", title: "Back", options: [])
               let action2 = UNNotificationAction(identifier: "action_2", title: "Next", options: [])
               let action3 = UNNotificationAction(identifier: "action_3", title: "View In App", options: [])
               let category = UNNotificationCategory(identifier: "CTNotification", actions: [action1, action2, action3], intentIdentifiers: [], options: [])
               UNUserNotificationCenter.current().setNotificationCategories([category])
    }
        
        
        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            NSLog("%@: failed to register for remote notifications: %@", self.description, error.localizedDescription)
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            NSLog("%@: registered for remote notifications: %@", self.description, deviceToken.description)
        }
        
//        func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                    didReceive response: UNNotificationResponse,
//                                    withCompletionHandler completionHandler: @escaping () -> Void) {
//
//            NSLog("%@: did receive notification response: %@", self.description, response.notification.request.content.userInfo)
//            completionHandler()
//        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            NSLog("%@: will present notification: %@", self.description, notification.request.content.userInfo)
         //   CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
            completionHandler([.badge, .sound, .alert])
        }
        
        func application(_ application: UIApplication,
                         didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            NSLog("%@: did receive remote notification completionhandler: %@", self.description, userInfo)
            completionHandler(UIBackgroundFetchResult.noData)
        }
        
        func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
            NSLog("pushNotificationTapped: customExtras: ", customExtras)
        }
        
        
        
        
        // MARK: UISceneSession Lifecycle
        
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
        
        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
            // Called when the user discards a scene session.
            // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
            // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        }
        
        // MARK: - Core Data stack
        
        lazy var persistentContainer: NSPersistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
             */
            let container = NSPersistentContainer(name: "DemoCtStoryBoard")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
        // MARK: - Core Data Saving support
        
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
        
    }


