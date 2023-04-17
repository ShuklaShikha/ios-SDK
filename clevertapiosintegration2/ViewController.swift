//
//  ViewController.swift
//  CTios
//
//  Created by Shikha Shukla on 04/04/23.
//

import UIKit
import CleverTapSDK



class ViewController: UIViewController, CleverTapInboxViewControllerDelegate,CleverTapDisplayUnitDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneno: UITextField!
    @IBOutlet weak var identity: UITextField!
    @IBOutlet weak var event: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAppInbox()
        initializeAppInbox()
        CleverTap.sharedInstance()?.setDisplayUnitDelegate(self)//for native display

      
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    

    
    //onuserlogin profile
    
    @IBAction func OnUserLogin(_ sender: Any) {
        let profile: Dictionary<String,Any> = [
            "Name": name.text!,
            "Email": email.text!,
            "Phone": phoneno.text!,
            "Identity": identity.text!
            
        ]
        CleverTap.sharedInstance()?.onUserLogin(profile)
        
        
        
    }
    //event
    @IBAction func Event(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent(event.text!)
        
    }
    //pushprofile or update the user details
    @IBAction func PushProfile(_ sender: Any) {
        let profile: Dictionary<String,Any> = [
            "Name": name.text!,
            "Email": email.text!,
            "Phone": phoneno.text!,
            "Identity": identity.text!
            
        ]
        CleverTap.sharedInstance()?.profilePush(profile)
        
        
    }
    
    
    
    @IBAction func recordUserChargedEvent(_ sender: Any) {
        //charged event
        let chargeDetails = [
            "Amount": 300,
            "Payment mode": "Credit Card",
            "Charged ID": 24052013
        ] as [String : Any]
        
        let item1 = [
            "Category": "books",
            "Book name": "The Millionaire next door",
            "Quantity": 1
        ] as [String : Any]
        
        let item2 = [
            "Category": "books",
            "Book name": "Achieving inner zen",
            "Quantity": 1
        ] as [String : Any]
        
        let item3 = [
            "Category": "books",
            "Book name": "Chuck it, let's do it",
            "Quantity": 5
        ] as [String : Any]
        
        CleverTap.sharedInstance()?.recordChargedEvent(withDetails: chargeDetails, andItems: [item1, item2, item3])
    }
    func registerAppInbox() {
           CleverTap.sharedInstance()?.registerInboxUpdatedBlock({
               let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
               let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
               print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
           })
       }
    
    func initializeAppInbox() {
            CleverTap.sharedInstance()?.initializeInbox(callback: ({ (success) in
                let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
                let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
                print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
            }))
        }
    
    @IBAction func showAppInbox(_ sender: Any) {
            
            // config the style of App Inbox Controller
            let style = CleverTapInboxStyleConfig.init()
            style.title = "App Inbox"
            style.navigationTintColor = .black
            
            if let inboxController = CleverTap.sharedInstance()?.newInboxViewController(with: style, andDelegate: self) {
                let navigationController = UINavigationController.init(rootViewController: inboxController)
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    
//    for native
    func displayUnitsUpdated(_ displayUnits: [CleverTapDisplayUnit]) {
           // you will get display units here
        var units:[CleverTapDisplayUnit] = displayUnits;
        print("native Display",units.first?.unitID)
        CleverTap.sharedInstance()?.recordDisplayUnitViewedEvent(forID:  (units.first?.unitID)!)
        
    }
//
}

extension ViewController{
    //Initialize the CleverTap App Inbox
    
    
}
