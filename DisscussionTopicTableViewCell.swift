//
//  DisscussionTopicTableViewCell.swift
//  Corgis
//
//  Created by Sal Valdes on 11/22/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

class DisscussionTopicTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var topicContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
