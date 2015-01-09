//
//  LoginViewController.swift
//  PhotoPro
//
//  Created by Lê Công on 1/9/15.
//  Copyright (c) 2015 Lê Công. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func authenticate(sender: AnyObject) {
        let context = LAContext()
        
        if (context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: nil)) {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate", reply: { (sucess: Bool, eror) -> Void in
                if (sucess) {
                    println("Sucess")
                } else {
                    println("Sucess")
                }
            })
        } else {
            println("Not allow")
            self.performSegueWithIdentifier("PRESENT", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }

}
