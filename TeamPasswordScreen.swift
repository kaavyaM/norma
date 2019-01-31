//
//  TeamPasswordScreen.swift
//  Corgis
//
//  Created by Kaavya on 11/12/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class TeamPasswordScreen: UIViewController {
    
    var gradientLayer: CAGradientLayer!
    
    @IBOutlet weak var _teampassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var defaultYPosition: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TeamPasswordScreen.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TeamPasswordScreen.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.createGradientLayer()
        defaultYPosition = self.view.frame.origin.y
        
        loginButton.layer.shadowColor = UIColor.gray.cgColor
        loginButton.layer.shadowOpacity = 0.5;
        loginButton.layer.shadowRadius = 1;
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4.0);

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        _teampassword.resignFirstResponder()
        if(_teampassword.text == "pass") {
            print("in loop")
            
            self.performSegue(withIdentifier: "segueToHome", sender: self)
        }
    }
    
    //MARK Private methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if (self.view.frame.origin.y == defaultYPosition) {
            self.view.frame.origin.y -= 0.3*self.view.frame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = defaultYPosition
    }



}
