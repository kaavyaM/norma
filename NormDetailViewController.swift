//
//  NormDetailViewController.swift
//  Corgis
//
//  Created by Sal Valdes on 11/4/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit
import os.log

class NormDetailViewController: UIViewController, UITextViewDelegate, UIPopoverPresentationControllerDelegate {

    //MARK: Properties
    var norm: Norm?
    
    @IBOutlet weak var normNameLabel: UILabel!
    @IBOutlet weak var normReasonLabel: UILabel!
   
    @IBOutlet weak var submitCommentAnonymously: UIButton!
    @IBOutlet weak var sendAppreciationButton: UIButton!
        
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var commentField: UITextView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    var defaultYPosition: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NormDetailViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NormDetailViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        defaultYPosition = self.view.frame.origin.y
        commentField.delegate = self
        
        if let norm = norm {
            navigationItem.title = norm.name
            normNameLabel.text = norm.name
            normReasonLabel.text = norm.reason
        }
        
        closeButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
 
        closeButton.clipsToBounds = true
        closeButton.setImage(UIImage(named:"encircled_x"), for: .normal)
        
        submitCommentAnonymously.layer.masksToBounds = true
        submitCommentAnonymously.layer.cornerRadius = 10
        submitCommentAnonymously.dropShadow()

        sendAppreciationButton.layer.masksToBounds = true
        sendAppreciationButton.layer.cornerRadius = 10
        sendAppreciationButton.dropShadow()
        
        ratingControl.rating = (norm?.rating)!
    }
    
    @IBAction func dismissDetailView(_ sender: UIButton) {
        Shared.normList.changeRating(id: (norm?.id)!, newRating: ratingControl.rating)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === closeButton else {
            os_log("The close button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }


    }
    

    @IBAction func submitComment(_ sender: UIButton) {
        Shared.discussionTopicList.add(type: "Comment", text: commentField.text, normId: norm?.id)
    }
    
    @IBAction func sendAppreciation(_ sender: UIButton) {
        self.performSegue(withIdentifier: "appreciationSegue", sender: NormDetailViewController.self)
    }
    
    //MARK: Private methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if (self.view.frame.origin.y == defaultYPosition) {
            self.view.frame.origin.y -= 0.4*self.view.frame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
            if (self.view.frame.origin.y != defaultYPosition) {
                self.view.frame.origin.y = defaultYPosition
        }
    }
    
    //MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentField.text = ""
        commentField.textColor = UIColor.black
        // Disable submit button while editing.
        submitCommentAnonymously.isEnabled = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !commentField.text.isEmpty {
            submitCommentAnonymously.isEnabled = true
        }
    }
    
    

}
