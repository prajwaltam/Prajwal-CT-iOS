//
//  NotificationService.swift
//  NotificationService
//
//  Created by Prajwal Jagadeesh on 29/05/24.
//

import UserNotifications
import CTNotificationService
import CleverTapSDK

class NotificationService: CTNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        print("-----Inside NotificationService------")
        let profile: Dictionary<String, String> = [
            //Update pre-defined profile properties
            "Name": "iOS Profile",
            "Email": "iosprofileprajwal@gmail.com",
        ]

        CleverTap.sharedInstance()?.onUserLogin(profile)
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData:request.content.userInfo)
                super.didReceive(request, withContentHandler: contentHandler)
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
