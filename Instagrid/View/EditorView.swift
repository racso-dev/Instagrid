//
//  EditorView.swift
//  Instagrid
//
//  Created by Oscar RENIER on 17/09/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import UIKit



// MARK: - Class used to wrapp the view inside the storyboard
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




// MARK: - Delegate protocol to communicate with the controller
protocol EditorViewDelegate: class {
    func addPicToButtonPressed()
}




// MARK: - View that corresponds to main grid
class EditorView: UIView {

    // MARK: - Enum that defines a specific style for the EditorView layout and the SelectionView according to a user action
    enum Style {
        case layout1, layout2, layout3
    }



    // MARK: - Instance that allows communications with the controller
    weak var delegate: EditorViewDelegate?



    // MARK: - Button that is sent to the UIImagePickerController so that his properties can edited in this view
    var buttonPressed : UIButton?



    // MARK: - All outlets of the buttons view
    @IBOutlet weak var upLeft: UIButton!
    @IBOutlet weak var upRight: UIButton!
    @IBOutlet weak var downLeft: UIButton!
    @IBOutlet weak var downRight: UIButton!



    // MARK: - Outlets of the left side buttons dimensions
    @IBOutlet weak var upLeftWidth: NSLayoutConstraint!
    @IBOutlet weak var downLeftWidth: NSLayoutConstraint!
    @IBOutlet weak var upLeftWidthLandscape: NSLayoutConstraint!
    @IBOutlet weak var downLeftWidthLandscape: NSLayoutConstraint!



    // MARK: - Buttons actions
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



    // MARK: - Set layout of the view
    var style : Style = .layout2 {
        didSet {
            setStyle(style: style)
        }
    }

    private func resetHiddenProp(hiddenButtons: [UIButton], dispButtons: [UIButton]) {

        for button in hiddenButtons {
            button.isHidden = true
        }

        for button in dispButtons {
            button.isHidden = false
        }

    }

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
    static func loadViewFromNib() -> EditorView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing:self), bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! EditorView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
