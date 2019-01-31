//
//  DiscussionTopicList.swift
//  Norma
//
//  Created by Sal Valdes on 12/5/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import Foundation
import UIKit
import os.log

class DiscussionTopicList {
    
    private var discussionTopics = [DiscussionTopic]()
    private var currentId: Int
    
    //MARK: Initialization
    
    init() {
        currentId = 0
        loadSampleDiscussionTopics()
    }
    
    //MARK: Public setters / getters
    func add(type: String, text: String, normId: Int?) {
        
        guard let discussionTopic = DiscussionTopic(type: type, text: text, id: currentId, normId: normId) else {
            fatalError("Failed to create dicussion topic")
        }
        discussionTopics += [discussionTopic]
        currentId += 1
    }
    
    func remove(id: Int) {
        for (i, discussionTopic) in discussionTopics.enumerated() {
            if (discussionTopic.id == id) {
                discussionTopics.remove(at: i)
                return
            }
        }
    }
    
    func get(index: Int)->DiscussionTopic {
        return discussionTopics[index]
    }
    
    func count()-> Int {
        return discussionTopics.count
    }
    //MARK: Private methods
    
    private func saveDiscussionTopics() {
        let isSucessfulSave = NSKeyedArchiver.archiveRootObject(discussionTopics, toFile: DiscussionTopic.ArchiveURL.path)
        if isSucessfulSave {
            os_log("DiscussionTopics successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save DiscussionTopics...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadDiscussionTopics() -> [DiscussionTopic]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: DiscussionTopic.ArchiveURL.path) as? [DiscussionTopic]
    }
    
    private func loadSampleDiscussionTopics() {
        let topicTypeNorm = "New Norm Suggestion"
        let topicTypeComment = "Comment"
        let topicTypeReview = "Review Due to Ratings"
        let newNorm = "Offer non-alcoholic beverages at happy hour."
        let comment = "It's easy to accidentally interrupt someone calling in to a meeting"
        let reviewText = "Don't microwave fish is getting poor ratings"
        
        self.add(type: topicTypeNorm, text: newNorm, normId: nil)
    
        self.add(type: topicTypeComment, text: comment, normId: 1)
        
        self.add(type: topicTypeReview, text: reviewText, normId: 2)
        }
}
