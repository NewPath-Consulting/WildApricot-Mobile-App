/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The main view controller for the application.
*/

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var deviceTokenLabel: UILabel!

    public var itemsInCart: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func subscribeToNotifications(_ sender: Any) {
        let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { (settings) in
                if(settings.authorizationStatus == .authorized)
                {
                    print("Button Check: notifcations are authorized")
                }
                else
                {
                    print("Button Check: notifcations are *not* authorized")
                }
            }
        
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
        }
//        self.shared.forward
    }

    public func showDeviceToken(_ tokenString: String) {
        deviceTokenLabel.text = "Device Token: \n\(tokenString)"
        
        let alertModal = UIAlertController(title: "test", message: tokenString, preferredStyle: .actionSheet)
        let copyAction = UIAlertAction(title: "copy to pasteboard", style: UIAlertAction.Style.default, handler:  {_ in
            //(action: UIALertAction!)
            let board = UIPasteboard.general
            board.string = tokenString
        })
        alertModal.addAction(copyAction)
        
        //hackout
//        present(alertModal, animated: true)
        
    }

}
