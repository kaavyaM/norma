//
//  GeneratedSuggestions.swift
//  Corgis
//
//  Created by Kaavya on 12/4/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class GeneratedSuggestions: UIViewController {
    
    @IBOutlet weak var fakeBackNav: UIStackView!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var backIconButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var submitAnonButton: UIButton!
    
    @IBOutlet weak var suggestion1Button: UIButton!
    @IBOutlet weak var suggestion2Button: UIButton!
    @IBOutlet weak var suggestion3Button: UIButton!
    
    var selectedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Rounding buttons
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = 10
        
        submitAnonButton.layer.masksToBounds = true
        submitAnonButton.layer.cornerRadius = 10
        
        // disable submit buttons
        submitButton.isEnabled = false
        submitAnonButton.isEnabled = false
        
        // coloring buttons
        suggestion1Button.backgroundColor = UIColor.white
        suggestion2Button.backgroundColor = UIColor.white
        suggestion3Button.backgroundColor = UIColor.white
        

        submitButton.backgroundColor = UIColor.init(hexString: "BDBDBD")
        submitAnonButton.backgroundColor = UIColor.init(hexString: "BDBDBD")
        submitAnonButton.setTitle("Submit Norm\n Anonymously", for: .normal)
        
        // back arrow at the bottom
        let leftArrow = UIImage(named: "left_arrow")
        backIconButton.setImage(leftArrow, for: .normal)
        backIconButton.contentMode = .scaleAspectFit
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fakeBackNav.createGradientLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func enableSubmitButtons() {
        submitButton.isEnabled = true
        submitButton.backgroundColor = UIColor.init(hexString: "27ae60")
        submitButton.dropShadow()
        
        submitAnonButton.isEnabled = true
        submitAnonButton.backgroundColor = UIColor.init(hexString: "27ae60")
        submitAnonButton.dropShadow()
    }
    
    func disableSubmitButtons() {
        submitButton.isEnabled = false
        submitButton.backgroundColor = UIColor.init(hexString: "BDBDBD")
        
        submitAnonButton.isEnabled = false
        submitAnonButton.backgroundColor = UIColor.init(hexString: "BDBDBD")
    }
    
    func enableSuggestions() {
        suggestion1Button.isEnabled = true
        suggestion2Button.isEnabled = true
        suggestion3Button.isEnabled = true
    }
    
    func disableSuggestions(button1: UIButton, button2: UIButton) {
        button1.isEnabled = false
        button2.isEnabled = false
    }
    
    func whitenSuggestions(sender: UIButton) {
        if (sender != suggestion1Button) {
        suggestion1Button.backgroundColor = UIColor.white
            suggestion1Button.setTitleColor(UIColor.gray, for: .normal)

        }
        if (sender != suggestion2Button) {
        suggestion2Button.backgroundColor = UIColor.white
        suggestion2Button.setTitleColor(UIColor.gray, for: .normal)

        }
        if (sender != suggestion3Button) {
        suggestion3Button.backgroundColor = UIColor.white
        suggestion3Button.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    @IBAction func suggestion1Tapped(_ sender: UIButton) {
        
        whitenSuggestions(sender: sender)
        
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = UIColor.init(hexString: "27ae60")
            
            enableSubmitButtons()
            sender.setTitleColor(UIColor.white, for: .normal)
            selectedButton = sender
        }
        else if sender.backgroundColor == UIColor.init(hexString: "27ae60"){
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor.gray, for: .normal)
            disableSubmitButtons()
            enableSuggestions()
        }
    }
    

    @IBAction func submitAnonButtonTapped(_ sender: UIButton) {
        let newNorm = selectedButton?.titleLabel?.text
        self.performSegue(withIdentifier: "toDiscussSegue", sender: GeneratedSuggestions.self)
        Shared.discussionTopicList.add(type: "New Norm Suggestion", text: newNorm!, normId: nil)
    }
    
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        let newNorm = selectedButton?.titleLabel?.text
        self.performSegue(withIdentifier: "toDiscussSegue", sender: GeneratedSuggestions.self)
        Shared.discussionTopicList.add(type: "New Norm Suggestion", text: newNorm!, normId: nil)
        
    }
    
    
    
}
