//
//  TeamNameLoginScreen.swift
//  Corgis
//
//  Created by Kaavya on 11/12/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class TeamNameLoginScreen: UIViewController, UITextFieldDelegate {
    
    var gradientLayer: CAGradientLayer!

    @IBOutlet weak var _teamName: UITextField!
    var defaultYPosition: CGFloat = 0.0
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _teamName.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(TeamNameLoginScreen.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TeamNameLoginScreen.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.createGradientLayer()
        defaultYPosition = self.view.frame.origin.y
        
        nextButton.layer.shadowColor = UIColor.gray.cgColor
        nextButton.layer.shadowOpacity = 0.5;
        nextButton.layer.shadowRadius = 1;
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 4.0);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitTeamName(_ sender: UIButton) {
        if(_teamName.text == "teamname") {
           self.performSegue(withIdentifier: "segueToTeamPassword", sender: self)
        }
        
    }
    
    //MARK Actions
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        _teamName.resignFirstResponder()
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
