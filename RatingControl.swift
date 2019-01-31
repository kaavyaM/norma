//
//  RatingControl.swift
//  Corgis
//
//  Created by Kaavya on 11/28/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    var norm: Norm?
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var faceSize: CGSize = CGSize(width: 75.0, height: 75.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var faceCount: Int = 3 {
        didSet {
            setupButtons()
        }
    }

    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    @objc     func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        
        let unselectedRatingImages = [UIImage(named: "frownface_grey_inverse", in: bundle, compatibleWith: self.traitCollection),
                        UIImage(named: "flatface_grey_inverse", in: bundle, compatibleWith: self.traitCollection),
                        UIImage(named: "happyface_grey_inverse", in: bundle, compatibleWith: self.traitCollection)]
        
        let selectedRatingImages = [UIImage(named: "frownface_red_inverse", in: bundle, compatibleWith: self.traitCollection),
                                      UIImage(named: "flatface_yellow_inverse", in: bundle, compatibleWith: self.traitCollection),
                                      UIImage(named: "happyface_green_inverse", in: bundle, compatibleWith: self.traitCollection)]
        
        for index in 0..<3 {
            // Create the button
            let button = UIButton()
            
            button.setImage(selectedRatingImages[index], for: .selected)
            button.setImage(unselectedRatingImages[index], for: .normal)
            button.setImage(selectedRatingImages[index], for: .highlighted)
            button.isSelected = norm?.rating == index + 1
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: -2, height: 3)
            button.layer.shadowOpacity = 0.5
            button.layer.shadowRadius = 2.0
            button.layer.masksToBounds = false
        
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: faceSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: faceSize.width).isActive = true
            
            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {

            button.isSelected = rating == index + 1
            
        }
    }
    
}
