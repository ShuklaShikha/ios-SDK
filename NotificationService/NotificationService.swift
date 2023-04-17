//
//  NotificationService.swift
//  NotificationService
//
//  Created by Shikha Shukla on 10/04/23.
//
//
//import UserNotifications
//import CTNotificationService
//import CleverTapSDK
//
//class NotificationService: CTNotificationServiceExtension {
//
//    var contentHandler: ((UNNotificationContent) -> Void)?
//    var bestAttemptContent: UNMutableNotificationContent?
//
//    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
//        self.contentHandler = contentHandler
//        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//
////        if let bestAttemptContent = bestAttemptContent {
////            // Modify the notification content here...
////            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
////
////            contentHandler(bestAttemptContent)
////        }
//        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: request.content.userInfo)
//        NSLog("%@: serviceextension called: %@")
//               super.didReceive(request, withContentHandler: contentHandler)
//    }
//
//}

import UserNotifications
import CleverTapSDK
import CTNotificationService
class NotificationService: CTNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        CleverTap.setDebugLevel(3)
        NSLog("Push impression")
//        CleverTap.sharedInstance()?.onUserLogin(profile)
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: request.content.userInfo)
        super.didReceive(request, withContentHandler: contentHandler)
    }
    

}
