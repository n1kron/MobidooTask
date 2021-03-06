//
//  SettingsTableViewController.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = "Настройки"
    }
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["info@mobidoo.io"])
        composeVC.setSubject("")
        composeVC.setMessageBody("", isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            SubscriptionManager.shared.resfreshReceipt()
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0 : Utiles.rate()
            case 1 :
                let activityVC = UIActivityViewController(activityItems: ["String to share"], applicationActivities: nil)
                present(activityVC, animated: true, completion: nil)
                if let popOver = activityVC.popoverPresentationController {
                    popOver.sourceView = self.view
                    Utiles.share(from: self)
                }
            case 2 :
                if !MFMailComposeViewController.canSendMail() {
                    print("Mail services are not available")
                    return
                }
                sendEmail()
            default: return
            }
        }
    }
}
