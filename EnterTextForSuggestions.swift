//
//  EnterTextForSuggestions.swift
//  Corgis
//
//  Created by Kaavya on 12/4/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class EnterTextForSuggestions: UIViewController {

 
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fakeBackNav: UIStackView!
    @IBOutlet weak var backIconButton: UIButton!
    @IBOutlet weak var generateSuggestions: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateSuggestions.layer.masksToBounds = true
        generateSuggestions.layer.cornerRadius = 10
        generateSuggestions.dropShadow()
        
        backButton.setTitle("Back to New Norm", for: .normal)
        
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
    
    @IBAction func generateSuggestions(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToSuggestion2", sender: self)
    }
    
    @IBAction func backButtonTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
