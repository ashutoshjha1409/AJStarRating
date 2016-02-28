// AUTHOR: Ashutosh Kumar Jha

import UIKit
import SnapKit

class RatingViewController: UIViewController {
    
    let screen = UIView()
    var rating = 0
    var ratingButtons = [UIButton]()
    var spacing = 5
    var stars = 5
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func layoutSubviews() {
        let buttonSize = 44
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    func intrinsicContentSize() -> CGSize {
        let buttonSize = 44
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //Do whatever you want here
        setup()
    }
    
    func setup(){
        self.view.addSubview(self.screen)
        
        // SCREEN
        screen.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 18, 18, 18))
        }
        
        let filledStarImage = UIImage(named: "rating_big_filled_blue")
        let emptyStarImage = UIImage(named: "rating_big_blue")
        
        // BUTTON
        for _ in 0..<stars {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            ratingButtons += [button]
            
            //button.backgroundColor = UIColor.redColor()
            
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            screen.addSubview(button)
        }
        layoutSubviews()
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        print(rating)
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }
}
