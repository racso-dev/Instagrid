//
//  SwipeView.swift
//  Instagrid
//
//  Created by Oscar RENIER on 24/11/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import UIKit



// MARK: - Class used to wrapp the view inside the storyboard
class WrapperSwipeView: UIView {

    var contentView: SwipeView

    required init?(coder aDecoder: NSCoder) {
        contentView = SwipeView.loadViewFromNib()
        super.init(coder: aDecoder)
        contentView.frame = bounds
        addSubview(contentView)
        translatesAutoresizingMaskIntoConstraints = false

        contentView.layoutMarginsGuide.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        contentView.layoutMarginsGuide.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true

    }
}



//MARK: - View that displays the appropriate text and arrow according to the orientation screen
class SwipeView: UIView {

    // MARK: - Outlet that are modified whenever the orientation changes
    @IBOutlet weak var swipeText: UILabel!
    @IBOutlet weak var arrowDirection: UIImageView!



    // MARK: - Function called when a change of screen orientation occurs
    override func layoutSubviews() {

        if UIDevice.current.orientation.isLandscape {
            swipeText.text = "Swipe left to share"
            arrowDirection.image = #imageLiteral(resourceName: "Arrow Left")
        } else {

            swipeText.text = "Swipe up to share"
            arrowDirection.image = #imageLiteral(resourceName: "Arrow Up")
        }

    }



    // MARK: - Loading the View
    static func loadViewFromNib() -> SwipeView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing:self), bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! SwipeView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
