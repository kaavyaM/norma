//
//  DiscussionTopicViewController.swift
//  Corgis
//
//  Created by Sal Valdes on 11/22/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit
import os.log


class DiscussionTopicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var meetingTopicView: UIStackView!
    
    @IBOutlet weak var backIconButton: UIButton!
    @IBOutlet weak var fakeBackNav: UIStackView!
    @IBOutlet weak var discussionTopicTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var startMeetingButton: UIButton!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var submitYourResponseButton: UIButton!
    @IBOutlet weak var votingView: UIStackView!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var disapproveButton: UIButton!
    @IBOutlet weak var userReasonTextView: UITextView!
    @IBOutlet weak var userReason: UILabel!
    @IBOutlet weak var suggestedNormText: UILabel!
    
    @IBOutlet weak var pendingNormText: UILabel!
    
    var currentDiscussionTopic: DiscussionTopic? = nil
    
    var meetingInSession: Bool = false
    
    @IBOutlet weak var userResponseTextView: UITextView!
    
    var defaultYPosition: CGFloat = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NormDetailViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NormDetailViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        userResponseTextView.delegate = self
        
        defaultYPosition = self.view.frame.origin.y
        
        meetingInSession = false
        meetingTopicView.isHidden = true
        votingView.isHidden = true
        
        discussionTopicTableView.delegate = self
        discussionTopicTableView.dataSource = self
        discussionTopicTableView.layer.borderColor = UIColor.black.cgColor
        discussionTopicTableView.layer.borderWidth = 1
        
        //Fake Navigation Tabbar
        backButton.setTitle("Back to " + teamName, for: .normal)
        let leftArrow = UIImage(named: "left_arrow")
        backIconButton.setImage(leftArrow, for: .normal)
        backIconButton.contentMode = .scaleAspectFit
        
        startMeetingButton.layer.masksToBounds = true
        startMeetingButton.layer.cornerRadius = 10
        startMeetingButton.dropShadow(offSet: CGSize(width: -1, height: 2), radius: 4)
        if ((Shared.discussionTopicList.count()) % 2 == 0) {
            discussionTopicTableView.backgroundColor = UIColor.white
        } else {
            discussionTopicTableView.backgroundColor = UIColor(hexString: "#F1F0F0")
        }
        
        startMeetingButton.setTitle("Meeting in Session", for: .disabled)
        startMeetingButton.setTitleColor(UIColor.gray, for: .disabled)
        
        submitYourResponseButton.layer.cornerRadius = 10
        submitYourResponseButton.dropShadow()
        skipButton.layer.cornerRadius = 10
        skipButton.dropShadow(offSet: CGSize(width: -1, height: 2), radius: 4)
        
        approveButton.layer.cornerRadius = 10
        disapproveButton.layer.cornerRadius = 10
        approveButton.dropShadow()
        disapproveButton.dropShadow()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fakeBackNav.createGradientLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverSegue" {
            let popoverViewController = segue.destination as! InfoViewController
            
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shared.discussionTopicList.count()
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DiscussionTopicTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DisscussionTopicTableViewCell else {
            fatalError("The dequeued cell is not an instance of the DiscussionTopicTableViewCell")
        }
        
        let discussionTopic = Shared.discussionTopicList.get(index: indexPath.row)
        cell.typeLabel?.text = discussionTopic.type
        cell.topicContent?.text = discussionTopic.text
        
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
    //MARK: Actions
    
    @IBAction func startMeetingButtonTouched(_ sender: UIButton) {
        startMeetingButton.isEnabled = false
        displayTopicForMeeting()
    }
    
    @IBAction func submitYourResponseTouched(_ sender: UIButton) {
        meetingTopicView.isHidden = true
        votingView.isHidden = false
        userReason.text = userReasonTextView.text
    }
    func displayTopicForMeeting() {
        discussionTopicTableView.isHidden = true
        votingView.isHidden = true
        currentDiscussionTopic = Shared.discussionTopicList.get(index: 0)
        titleText.text = currentDiscussionTopic?.type
        suggestedNormText.text = currentDiscussionTopic?.text
        pendingNormText.text = currentDiscussionTopic?.text
        meetingTopicView.isHidden = false
        userResponseTextView.textColor = UIColor.gray
    }
    
    @IBAction func approveButtonTouched(_ sender: UIButton) {
        if (currentDiscussionTopic?.type == "New Norm Suggestion") {
            Shared.normList.add(name: (currentDiscussionTopic?.text)!, reason: userReason.text!)
        }
        if (currentDiscussionTopic?.type == "Comment" || currentDiscussionTopic?.type == "Review Due to Ratings") {
            Shared.normList.appendReason(id: (currentDiscussionTopic?.normId)!, additionalReason: userReason.text!)
        }

        Shared.discussionTopicList.remove(id: (currentDiscussionTopic?.id)!)
        
        if (Shared.discussionTopicList.count() > 0) {
            displayTopicForMeeting()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        userReason.text = "Type here"
    }
    
    @IBAction func disapproveButtonTouched(_ sender: UIButton) {
        
    }
    @IBAction func normImportantInfoButtonTouched(_ sender: UIButton) {
        Shared.infoLabel = "Why is this norm important?"
        Shared.infoContent = "All comments here will be compiled into the norms “about” page to remind people of it's importance. Norma merges repeated reasons, so don't worry about saying what everyone else has said!\n It’s important to include everyone’s input as to why a norm is made. After filling it out, and ensuring people understand the norm, you will be prompted to vote on whether or not to accept the norm."
    }
    
    @IBAction func votingInfoButtonTouched(_ sender: Any) {
        Shared.infoLabel = "Voting"
        Shared.infoContent = "Every member of a team has to vote on a norm before it is approved or disapproved. You will get a notification whether or not the norm has been approved. After voting, you can return to the home page."
    }
    
    @IBAction func startMeetingInfoButtonTouched(_ sender: UIButton) {
        Shared.infoLabel = "Meetings"
        Shared.infoContent = "We suggest discussing these items with your team members. This will help you best make decisions and decide how to best implement these norms."
    }
    
    //MARK Navigation
    
    @IBAction func backToHome(_ sender: UIButton) {
        if let viewControllers = self.navigationController?.viewControllers {
        if viewControllers.count > 1 {
            self.navigationController?.popToViewController(viewControllers[0], animated: true)
        }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Roll viewController up for keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if (self.view.frame.origin.y == defaultYPosition) {
            self.view.frame.origin.y -= 0.25*self.view.frame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if (self.view.frame.origin.y != defaultYPosition) {
            self.view.frame.origin.y = defaultYPosition
        }
    }
    
    //MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        userResponseTextView.text = ""
        userResponseTextView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !userResponseTextView.text.isEmpty {
            submitYourResponseButton.isEnabled = true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        userResponseTextView.resignFirstResponder()
        return true
    }
    

}
