//
//  ViewController.swift
//  Raied
//
//  Created by meshal binnasban on 13/07/1439 AH.
//  Copyright © 1439 meshal binnasban. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let url1 = "http://www.art.com.sa"
    

    @IBOutlet weak var homeMenuButton: UIButton!
    
    @IBOutlet weak var webView: WKWebView!
    
     var progressBar: UIProgressView!
    
    @IBOutlet weak var viewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewLeadingConstraint: NSLayoutConstraint!
    
    var menuShowing = false
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let widthConstraint = homeMenuButton.widthAnchor.constraint(equalToConstant: 32)
        let heightConstraint = homeMenuButton.heightAnchor.constraint(equalToConstant: 32)
        
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        
        let logo = UIImage(named: "naviImage.png")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit // set imageview's content mode
        self.navigationItem.titleView = imageView
        //
        
        self.webView.isHidden=false
   
        progressBar=UIProgressView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        progressBar.progress=0
        progressBar.tintColor=UIColor.cyan
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        webView.addSubview(progressBar)
        
        
        if let url=URL(string: url1) {
            let urlRequest=URLRequest(url:url)
            self.webView.load(urlRequest)
        }else{
            print("what")
        }
        
    }//end of viewDidLoad()
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath=="estimatedProgress" {
            progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
            
            if self.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3,delay:0.1, options:UIViewAnimationOptions.curveEaseIn ,  animations: {()-> Void in  self.progressBar.alpha=0.0} , completion: {(finished:Bool) -> Void in self.progressBar.progress=0})
                
            }
        }//end if key
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }

    override func viewDidAppear(_ animated: Bool) {
       // UIView.animate(withDuration: 0, animations:{
          //  self.backgroundIMG.alpha=0
       // }, completion: {(finished : Bool) in
       // })
    }
    
    @IBAction func leftButton(_ sender: Any) {
        if(self.webView.canGoBack) {
            //Go back in webview history
            
            self.webView.goBack()
        } else {
            //Pop view controller to preview view controller
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func homeButton(_ sender: Any) {
        let url = URL(string: url1)
        
        if let url=url {
            let urlRequest = URLRequest(url: url)
            self.webView.load(urlRequest)
        }
    }
    
    @IBAction func rightButton(_ sender: Any) {
        
        if(self.webView.canGoForward) {
            //Go back in webview history
            self.webView.goForward()
        } else {
            //Pop view controller to preview view controller
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    @IBAction func homePagebuttonPressed(_ sender: Any) {
        
        homeButton((Any).self)
        viewLeadingConstraint.constant = 0
        viewTrailingConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    @IBAction func showMainMenuButtonPressed(_ sender: Any) {
        
        if menuShowing {
            viewLeadingConstraint.constant = 0
            viewTrailingConstraint.constant = 0
            
        }else{
            viewLeadingConstraint.constant = 110
            viewTrailingConstraint.constant = -110
            
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
        
    }
    
    
    
    
}

