//
//  LoginScreen.swift
//  Corgis
//
//  Created by Kaavya on 11/11/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class LoginScreen: UIViewController {
    
    var gradientLayer: CAGradientLayer!
    
    
    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var defaultYPosition: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginScreen.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginScreen.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.createGradientLayer()
        defaultYPosition = self.view.frame.origin.y
        
        // add shadow to submitButton
        submitButton.layer.shadowColor = UIColor.gray.cgColor
        submitButton.layer.shadowOpacity = 0.5;
        submitButton.layer.shadowRadius = 1;
        submitButton.layer.shadowOffset = CGSize(width: 0, height: 4.0);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        _username.resignFirstResponder()
        _password.resignFirstResponder()
    }
    
    @IBAction func button(_ sender: UIButton) {
        
        print(_username.text!)
        print(_password.text!)
        if(_username.text == "user" && _password.text == "pass") {
            print("in loop")
           
            self.performSegue(withIdentifier: "segue1", sender: LoginScreen.self)
        }
    }
    
    //MARK Private methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if (self.view.frame.origin.y == defaultYPosition) {
            self.view.frame.origin.y -= 0.4*self.view.frame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
            self.view.frame.origin.y = defaultYPosition
    }

}
