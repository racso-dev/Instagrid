//
//  SelectionView.swift
//  Instagrid
//
//  Created by Oscar RENIER on 22/09/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import UIKit



// MARK: - Class used to wrapp the view inside the storyboard
class WrapperSelectionView: UIView {

    var contentView: SelectionView

    required init?(coder aDecoder: NSCoder) {
        contentView = SelectionView.loadViewFromNib()
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
protocol SelectionViewDelegate: class {

    func updateEditorViewStyle(selectionViewStyle: SelectionView.Style)

}



// MARK: - View that is display all layout buttons selection
class SelectionView: UIView {

    // MARK: - Enum that defines a specific style to the view according to a user action
    enum Style {
        case layout1, layout2, layout3
    }



    // MARK: - Implementation of the delegate to communicate with the controller
    weak var delegate: SelectionViewDelegate?



    // MARK: - All outlets of the buttons view
    @IBOutlet weak var leftLay : UIButton!
    @IBOutlet weak var midLay : UIButton!
    @IBOutlet weak var rightLay : UIButton!



    // MARK: - Buttons actions
    @IBAction func didSelectLayout1() {
        self.style = .layout1
        delegate?.updateEditorViewStyle(selectionViewStyle: .layout1)
    }

    @IBAction func didSelectLayout2() {
        self.style = .layout2
        delegate?.updateEditorViewStyle(selectionViewStyle: .layout2)
    }

    @IBAction func didSelectLayout3() {
        self.style = .layout3
        delegate?.updateEditorViewStyle(selectionViewStyle: .layout3)
    }



    // MARK: - Style of the View set according to the current selected selection layout button
    var style : Style = .layout2 {
        didSet {
            setStyle(style: style)
        }
    }

    private func setStyle(style: Style) {
        switch style {
        case .layout1:
            leftLay.setBackgroundImage(#imageLiteral(resourceName: "Layout 1 Slct"), for: .normal)
            midLay.setBackgroundImage(#imageLiteral(resourceName: "Layout 2"), for: .normal)
            rightLay.setBackgroundImage(#imageLiteral(resourceName: "Layout 3"), for: .normal)

        case .layout2:
            leftLay.setBackgroundImage(#imageLiteral(resourceName: "Layout 1"), for: .normal)
            midLay.setBackgroundImage(#imageLiteral(resourceName: "Layout 2 Slct"), for: .normal)
            rightLay.setBackgroundImage(#imageLiteral(resourceName: "Layout 3"), for: .normal)

        case .layout3:
            leftLay.setBackgroundImage(#imageLiteral(resourceName: "Layout 1"), for: .normal)
            midLay.setBackgroundImage(#imageLiteral(resourceName: "Layout 2"), for: .normal)
            rightLay.setBackgroundImage(#imageLiteral(resourceName: "Layout 3 Slct"), for: .normal)

        }
    }



    //MARK: - Loading the View
    static func loadViewFromNib() -> SelectionView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing:self), bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! SelectionView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
