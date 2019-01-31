//
//  NormViewController.swift
//  Corgis
//
//  Created by Sal Valdes on 11/12/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit
import os.log

class NormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var gradientLayer: CAGradientLayer!
    
    @IBOutlet weak var photoStackView: UIStackView!
    //MARK: Properties
    @IBOutlet weak var teamPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var teamPhotoImageView: UIImageView!
    @IBOutlet weak var teamPhotoSelectLabel: UILabel!
    @IBOutlet weak var normTableView: UITableView!
    @IBOutlet weak var fakeTabbar: UIStackView!
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var discussionTopicsButton: UIButton!
// make leading and trailing C
    
    @IBOutlet weak var trailingC: NSLayoutConstraint!
    @IBOutlet weak var leadingC: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var menuItem1: UIButton!
    @IBOutlet weak var menuItem2: UIButton!
    
    
    
    var menuIsVisible = false;
    
    
    let ratingImages = [UIImage(named: "happyface_grey_inverse.png")!, UIImage(named: "frownface_red_inverse.png")!, UIImage(named: "flatface_yellow_inverse.png")!, UIImage(named: "happyface_green_inverse.png")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        normTableView.delegate = self
        normTableView.dataSource = self
        menuView.createGradientLayer()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.normTableView.reloadData()
        fakeTabbar.createGradientLayer()
        menuView.createGradientLayer()
        
        menuButton.imageView?.contentMode = .scaleAspectFit
        discussionTopicsButton.imageView?.contentMode = .scaleAspectFit
        addButton.imageView?.contentMode = .scaleAspectFit
        
        // Make discussion topics appear disabled when list is empty
        if (Shared.discussionTopicList.count() == 0) {
            discussionTopicsButton.isEnabled = false
        }
        
        // Adds subview thing! Eventually put this into the nav button segue, not here.
        //getMenu()
       

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shared.normList.count()
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "NormTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NormTableViewCell else {
            fatalError("The dequeued cell is not an instance of NormTableViewCell.")
        }
        
        // Fetches the appropriate norm for the data source layout.
        let norm = Shared.normList.get(index: indexPath.row)

        cell.nameLabel.text = norm.name
        cell.ratingImageView.image = ratingImages[norm.rating]
        cell.reasonLabel.text = norm.reason
        
        if( indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor.white
        }
        else{
            cell.backgroundColor = UIColor(hexString: "#F1F0F0")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90.0;//Custom row height
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
            
        case "ShowDetail":
            guard let normDetailViewController = segue.destination as? NormDetailViewController else {
                fatalError("Unexpected destination identifier: \(segue.destination)")
            }
            
            guard let selectedNormCell = sender as? NormTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = normTableView.indexPath(for: selectedNormCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedNorm = Shared.normList.get(index: indexPath.row)
            normDetailViewController.norm = selectedNorm
            
        case "ToDiscussionTopics":
            guard let discussionTopicViewController = segue.destination as? DiscussionTopicViewController else {
                fatalError("Unexpected destination identifier: \(segue.destination)")
            }
            
        case "AddNewNorm":
            guard let newNormViewController = segue.destination as? AddDisccusionTopicViewController else {
                fatalError("Unexpected destination identifier: \(segue.destination)")
            }
            
        default:
            fatalError("Unexpected segue identifier: \(String(describing: segue.identifier))")
        }
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        teamPhotoImageView.image = selectedImage
        teamPhotoImageView.contentMode = .scaleAspectFill
        teamPhotoSelectLabel.text = "Norms for " + teamName
        teamPhotoSelectLabel.numberOfLines = 2
        teamPhotoSelectLabel.backgroundColor = UIColor(red: 141, green: 141, blue: 141, alpha: 0.3)
        teamPhotoSelectLabel.textColor = .white
        teamPhotoSelectLabel.textAlignment = .left
        teamPhotoHeight.constant = 0.35*self.view.frame.height
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        //if the  menu is NOT visible, then move the ubeView back to where it used to be
        if !menuIsVisible {
            leadingC.constant = 150
            //this constant is NEGATIVE because we are moving it 150 points OUTWARD and that means -150
            trailingC.constant = -150
            
            //1
            menuIsVisible = true
            menuView.backgroundColor = UIColor.init(hexString: "4fcc83")
            
        } else {
            //if the  menu IS visible, then move the ubeView back to its original position
            leadingC.constant = 0
            trailingC.constant = 0
            
            //2
            menuIsVisible = false
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
        menuView.createGradientLayer()
    }
        
    @IBAction func menuItem1(_ sender: UIButton) {
        if(menuItem1.backgroundColor == UIColor.white) {
            menuItem1.backgroundColor = UIColor.gray
            menuItem2.backgroundColor = UIColor.white
        } else {
            menuItem1.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func menuItem2(_ sender: Any) {
        if(menuItem2.backgroundColor == UIColor.white) {
            menuItem2.backgroundColor = UIColor.gray
            menuItem1.backgroundColor = UIColor.white
        } else {
            menuItem2.backgroundColor = UIColor.white
        }
    }
    
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    

    

}
