//
//  appreciateTeamMember.swift
//  Norma
//
//  Created by Kaavya on 12/7/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class appreciateTeamMember: UIViewController {
    
    @IBOutlet weak var person1: UIButton!
    @IBOutlet weak var person2: UIButton!
    @IBOutlet weak var person3: UIButton!
    @IBOutlet weak var person4: UIButton!
    
    @IBOutlet weak var appreciationButton: UIButton!
    
    var numberOfPeople = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeButtons()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeButtons() {
        roundButtons()
        colorButtonsGray()
        
        appreciationButton.isEnabled = false
    }
    
    func roundButtons() {
        person1.layer.masksToBounds = true
        person1.layer.cornerRadius = 10
        
        person2.layer.masksToBounds = true
        person2.layer.cornerRadius = 10
        
        person3.layer.masksToBounds = true
        person3.layer.cornerRadius = 10
        
        person4.layer.masksToBounds = true
        person4.layer.cornerRadius = 10
        
        appreciationButton.layer.masksToBounds = true
        appreciationButton.layer.cornerRadius = 10
    }
    
    func colorButtonsGray() {
        person1.backgroundColor = UIColor.init(hexString: "BDBDBD")
        person2.backgroundColor = UIColor.init(hexString: "BDBDBD")
        person3.backgroundColor = UIColor.init(hexString: "BDBDBD")
        person4.backgroundColor = UIColor.init(hexString: "BDBDBD")
        
        appreciationButton.backgroundColor = UIColor.init(hexString: "BDBDBD")
    }
    
    func chosen(button: UIButton) -> Bool {
        return (button.backgroundColor == UIColor.init(hexString: "27ae60"))
    }
    
    func choose(button: UIButton) {
        button.backgroundColor = UIColor.init(hexString: "27ae60")
        appreciationButton.isEnabled = true
        appreciationButton.backgroundColor = UIColor.init(hexString: "27ae60")
        numberOfPeople += 1;
    }
    
    func unchoose(button: UIButton) {
        button.backgroundColor = UIColor.init(hexString: "BDBDBD")
        numberOfPeople -= 1;
        if(numberOfPeople < 1) {
            appreciationButton.isEnabled = false
            appreciationButton.backgroundColor = UIColor.init(hexString: "BDBDBD")
        }
    }
    
    @IBAction func person1Click(_ sender: UIButton) {
        if (!chosen(button: person1)) {
            choose(button: person1)
        } else {
            unchoose(button: person1)
        }
    }
    
    @IBAction func person2Click(_ sender: UIButton) {
        if (!chosen(button: person2)) {
            choose(button: person2)
        } else {
            unchoose(button: person2)
        }
    }
    
    @IBAction func person3Click(_ sender: UIButton) {
        if (!chosen(button: person3)) {
            choose(button: person3)
        } else {
            unchoose(button: person3)
        }
    }
    
    @IBAction func person4Click(_ sender: UIButton) {
        if (!chosen(button: person4)) {
            choose(button: person4)
        } else {
            unchoose(button: person4)
        }
    }
    
    @IBAction func sendApprClick(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
