//
//  AddDisccusionTopicViewController.swift
//  Corgis
//
//  Created by Sal Valdes on 10/24/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit
import os.log


class AddDisccusionTopicViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var suggestNormField: UITextView!
    
    var norm: Norm?
    var discussionTopic: DiscussionTopic?
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitAnonymously: UIButton!
    @IBOutlet weak var findSuggestionsButton: UIButton!
    @IBOutlet weak var backIconButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fakeBackNav: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestNormField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddDisccusionTopicViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddDisccusionTopicViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
        
        backButton.setTitle("Back to " + teamName, for: .normal)
        let leftArrow = UIImage(named: "left_arrow")
        backIconButton.setImage(leftArrow, for: .normal)
        backIconButton.contentMode = .scaleAspectFit
        
        // button rounded corners
        submitButton.layer.masksToBounds = true
        submitButton.dropShadow()
        submitAnonymously.layer.masksToBounds = true
        submitAnonymously.dropShadow()
        suggestNormField.layer.masksToBounds = true
        findSuggestionsButton.layer.masksToBounds = true
        
        submitButton.layer.cornerRadius = 10.0
        submitAnonymously.layer.cornerRadius = 10.0
        suggestNormField.layer.cornerRadius = 5.0
        findSuggestionsButton.layer.cornerRadius = 10.0
        findSuggestionsButton.dropShadow()
        
        // Enable the submit button only if text exists in the suggested norm field
        updateSubmitButtonState()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fakeBackNav.createGradientLayer()
    }

    //MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        suggestNormField.text = ""
        suggestNormField.textColor = UIColor.black
        // Disable submit button while editing.
        submitButton.isEnabled = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.clear.cgColor
        updateSubmitButtonState()
        navigationItem.title = suggestNormField.text
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the submitButton is pressed
        guard let button = sender as? UIButton, button === submitButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let reason = suggestNormField.text ?? ""
        
        Shared.discussionTopicList.add(type: "New Norm Suggestion", text: reason, normId: nil)
    }
    
    
    
    //MARK: Actions
    @objc func tap(gesture: UITapGestureRecognizer) {
        suggestNormField.resignFirstResponder()
    }
    
    @IBAction func submitNewNorm(_ sender: UIButton) {
        suggestNormField.resignFirstResponder()
        
    }
    @IBAction func backButtonTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: Private Methods
    private func updateSubmitButtonState() {
        // Disable the submit button if the text view is empty
        let text = suggestNormField.text ?? ""
        submitButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func findSuggestions(_ sender: Any) {
        self.performSegue(withIdentifier: "segueToSuggestion1", sender: self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= 0.25*keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y += 0.25*keyboardSize.height
        }
    }

}
