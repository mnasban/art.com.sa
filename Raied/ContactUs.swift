//
//  ContactUs.swift
//  Raied
//
//  Created by meshal binnasban on 08/09/2018.
//  Copyright © 2018 meshal binnasban. All rights reserved.
//

import UIKit
import MessageUI

class ContactUs: UIViewController, MFMailComposeViewControllerDelegate , UITextFieldDelegate, UITextViewDelegate{

    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var bodyTextArea: UITextView!
    
    let mail = MFMailComposeViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectTextField.delegate = self
        bodyTextArea.delegate = self
     
        
       
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        subjectTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ContactButtonPressed(_ sender: Any) {
       
        
        if MFMailComposeViewController.canSendMail() {
          
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@art.com.sa"])
            mail.setSubject(subjectTextField.text!)
            mail.setMessageBody(bodyTextArea.text, isHTML: false)
            mail.setSubject(subjectTextField.text!)

            self.present(mail, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "خطأ في الاتصال بالخادم", message: "الرجاء المحاوله مرة اخرى", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "حسنا", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
   
    
   

}
