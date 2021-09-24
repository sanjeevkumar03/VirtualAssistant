//
//  SSOWebVCViewController.swift
//  Collabtic
//
//  Created by Ajeet Sharma on 30/06/20.
//  Copyright © 2020 Collabtic. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

protocol SSOWebVCViewControllerDelegate {
    func ssoLoggedInSuccessfullyWith(sessionId:String)
}

class SSOWebVCViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var containerView: UIView!
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var ssoURLStr = ""
    var isFirstTime = false
    var hud:MBProgressHUD?
    var delegate:SSOWebVCViewControllerDelegate!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        containerView.layer.cornerRadius = 10
        self.show()
        webView.navigationDelegate = self
        self.loadWV()
    }
    
    
    func show()
       {
           self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           self.view.alpha = 0.0;
           UIView.animate(withDuration: 0.25, animations: {
               self.view.alpha = 1.0
               self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
               
           });
       }
       
       func remove()
       {   
           UIView.animate(withDuration: 0.25, animations: {
               self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
               self.view.alpha = 0.0;
           }, completion:{(finished : Bool)  in
               if (finished)
               {
                   self.view.removeFromSuperview()
               }
           });
       }

    
    func loadWV() {
        let link = URL(string:ssoURLStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        let request = URLRequest(url: link)
        webView.load(request)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
         self.remove()
    }
}

extension SSOWebVCViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish: WKNavigation!){
        self.hud?.hide(animated: true)
       }
       func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        if !isFirstTime{
//            isFirstTime = true
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        }
//        else{
//            self.hud?.show(animated: true)
//        }
       }
       func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
         //  if (navigationAction.request.url?.lastPathComponent == "inter_mobile"){
           if let url = navigationAction.request.url?.absoluteURL{

            print("URL ==== \(url.valueOfParameter("data") ?? "")")
            let data = url.valueOfParameter("data") ?? ""
            if data != ""{
            self.delegate.ssoLoggedInSuccessfullyWith(sessionId: data)
                self.remove()
            }
//            Base.url = self.cbaBaseUrl
//            print("URL ==== \(Base.url)")
//
//            self.callCBALoginAPI(sessionId: url.valueOfParameter("data") ?? "")
        
        print(navigationAction.request.url)
              
           decisionHandler(.allow)
     }
}
}


