//
//  InfoViewController.swift
//  Norma
//
//  Created by Sal Valdes on 12/7/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var infoContent: UILabel!
    
    override func viewDidLoad() {
        infoLabel.text = Shared.infoLabel
        infoContent.text = Shared.infoContent
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        infoLabel.text = Shared.infoLabel
        infoContent.text = Shared.infoContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
