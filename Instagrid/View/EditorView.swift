//
//  EditorView.swift
//  Instagrid
//
//  Created by Oscar RENIER on 17/09/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import UIKit



// MARK: - Wrapper



/// Class used to wrapp the EditorView inside the storyboard
class WrapperEditorView: UIView {

    var contentView: EditorView

    required init?(coder aDecoder: NSCoder) {
        contentView = EditorView.loadViewFromNib()
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




// MARK: - Delegate protocol



/// Protocol that notifies the controller whenever an image needs to be selected
protocol EditorViewDelegate: class {
    func addPicToButtonPressed()
}




// MARK: - Main view



/// View that corresponds to main grid
class EditorView: UIView {

    // MARK: - Properties



    /// Enum that defines a specific style for the EditorView layout and the SelectionView according to a user action
    enum Style {
        case layout1, layout2, layout3
    }



    /// Property that corresponds to the view's current layout
    var style : Style = .layout2 {
        didSet {
            setStyle(style: style)
        }
    }



    /// Instance that allows communications with the controller
    weak var delegate: EditorViewDelegate?



    /// The touched EditorView's button that is called in the UIImagePickerControllerDelegate so that his properties can be edited with the picked image
    var buttonPressed : UIButton?



    // All outlets of the buttons view
    @IBOutlet weak var upLeft: UIButton!
    @IBOutlet weak var upRight: UIButton!
    @IBOutlet weak var downLeft: UIButton!
    @IBOutlet weak var downRight: UIButton!



    // All outlets of the left side buttons dimensions
    @IBOutlet weak var upLeftWidth: NSLayoutConstraint!
    @IBOutlet weak var downLeftWidth: NSLayoutConstraint!
    @IBOutlet weak var upLeftWidthLandscape: NSLayoutConstraint!
    @IBOutlet weak var downLeftWidthLandscape: NSLayoutConstraint!



    // MARK: - Actions


    // Actions triggered to add a selected image to a pressed button
    @IBAction func didAddPic1(_ sender: Any) {
        buttonPressed = upLeft
        delegate?.addPicToButtonPressed()
    }
    @IBAction func didAddPic2(_ sender: Any) {
       buttonPressed = upRight
        delegate?.addPicToButtonPressed()
    }
    @IBAction func didAddPic3(_ sender: Any) {
        buttonPressed = downLeft
        delegate?.addPicToButtonPressed()
    }
    @IBAction func didAddPic4(_ sender: Any) {
        buttonPressed = downRight
        delegate?.addPicToButtonPressed()
    }



    // MARK: - View's style methods

    /// A method that shows or hides two given list of buttons
    private func resetHiddenProp(hiddenButtons: [UIButton], dispButtons: [UIButton]) {

        for button in hiddenButtons {
            button.isHidden = true
        }

        for button in dispButtons {
            button.isHidden = false
        }

    }



    /// A method that manipulates all the necessary elements to make the view fit a given style
    private func setStyle(style: Style) {
        switch style {
        case .layout1:
            resetHiddenProp(hiddenButtons: [upRight], dispButtons: [upLeft, downLeft, downRight])
            upLeftWidth.constant = 270
            downLeftWidth.constant = 127
            upLeftWidthLandscape.constant = 220
            downLeftWidthLandscape.constant = 102

        case .layout2:
            resetHiddenProp(hiddenButtons: [downRight], dispButtons: [downLeft, upLeft, upRight])
            upLeftWidth.constant = 127
            downLeftWidth.constant = 270
            upLeftWidthLandscape.constant = 102
            downLeftWidthLandscape.constant = 220

        case .layout3:
            resetHiddenProp(hiddenButtons: [], dispButtons: [downRight, downLeft, upLeft, upRight])
            upLeftWidth.constant = 127
            downLeftWidth.constant = 127
            upLeftWidthLandscape.constant = 102
            downLeftWidthLandscape.constant = 102

        }
    }



    // MARK: - Loading the view



    /// Called to instantiate the content view of the wrapper view
    static func loadViewFromNib() -> EditorView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing:self), bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! EditorView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
