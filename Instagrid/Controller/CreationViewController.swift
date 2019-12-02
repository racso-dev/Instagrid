//
//  CreationViewController.swift
//  Instagrid
//
//  Created by Oscar RENIER on 13/09/2019.
//  Copyright © 2019 Oscar RENIER. All rights reserved.
//

import UIKit



// MARK: - Controller



/// The creation view controller that coordinates all views
class CreationViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Properties



    // All outlets subviews
    @IBOutlet weak var editorView: WrapperEditorView!
    @IBOutlet weak var selectionView: WrapperSelectionView!
    @IBOutlet weak var swipeView: WrapperSwipeView!



    /// Instance of the Converter class that used to convert a UIView to a UIImage
    var convert = Converter()



    // MARK: - Sharing flow



    /// Call the appropriate animation whenever a swipe to share occurs according to the orientation of the screen
    @objc func swipeInterpretor(_ sender: UISwipeGestureRecognizer) {

        switch sender.direction {
        case .left:
            if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
                animateViews(posX: (-UIScreen.main.bounds.width), posY: 0, duration: 0.5, reversed: false)
                shareImage()
            }
        case .up:
            if UIDevice.current.orientation == .portrait {
                animateViews(posX: 0, posY: (-UIScreen.main.bounds.height), duration: 0.5, reversed: false)
                shareImage()
            }
        default:
            break
        }

    }



//    /// Method called whenever a swipe occurs to check if all the displayed EditorView's buttons are filled with a user selected image
//    private func isEditorViewReadyToBeShared() -> Bool {
//
//        let editorViewButtons = [editorView.contentView.upLeft, editorView.contentView.upRight, editorView.contentView.downLeft, editorView.contentView.downRight]
//
//        for button in editorViewButtons {
//
//            if !button!.isHidden {
//
//                if (button?.currentImage != nil) {
//
//                    continue
//
//                } else {
//
//                    return false
//
//                }
//
//            }
//
//        }
//
//        return true
//
//    }



    /// Called right after a swipe occurs to show the UIActivityViewController
    private func shareImage() {

        let image = self.convert.viewToUIImage(with: self.editorView.contentView)

        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        shareController.completionWithItemsHandler = { activity, success, items, error in
            if !success {
                self.animateViews(posX: 0, posY: 0, duration: 0.1, reversed: true)
            }
        }
        self.present(shareController, animated: true, completion: nil)

    }



    /// Method that animates editorView and swipeView whenever a swipe occurs
    private func animateViews(posX: CGFloat, posY: CGFloat, duration: TimeInterval, reversed: Bool) {

        let widthEditorView = self.editorView.contentView.bounds.width as CGFloat
        let heightEditorView = self.editorView.contentView.bounds.height as CGFloat

        let widthSwipeView = self.swipeView.contentView.bounds.width as CGFloat
        let heightSwipeView = self.swipeView.contentView.bounds.height as CGFloat

        UIView.animate(withDuration: duration) {

            self.editorView.contentView.frame = CGRect(x: posX, y: posY, width: widthEditorView, height: heightEditorView)
            self.swipeView.contentView.frame = CGRect(x: posX, y: posY, width: widthSwipeView, height: heightSwipeView)
        }
    }



    // MARK: - View's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        selectionView.contentView.style = .layout2

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeInterpretor(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeInterpretor(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)

        editorView.contentView.delegate = self
        selectionView.contentView.delegate = self
    }

}




// MARK: - CreationViewController's extensions



/// Implementation of the EditorViewDelegate to notify the controller when a pic needs to be added to the pressed button
extension CreationViewController: EditorViewDelegate {

    func addPicToButtonPressed() {
        let actionSheet = UIAlertController(title: "Source", message: "", preferredStyle: .actionSheet)

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(imagePickerController, animated: true, completion: nil)
    }

}




// MARK: - Implementation of the SelectionViewDelegate to notify the controller that the EditorView's style needs to be updated according to the selected layout
extension CreationViewController: SelectionViewDelegate {

    func updateEditorViewStyle(selectionViewStyle: SelectionView.Style) {
        switch selectionViewStyle {
        case .layout1:
            editorView.contentView.style = .layout1
        case .layout2:
            editorView.contentView.style = .layout2
        case .layout3:
            editorView.contentView.style = .layout3
        }
    }

}




// MARK: - Implementation of the UIImagePickerControllerDelegate to implement the imagePickerController function that is called when a pic needs to be selected
extension CreationViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            editorView.contentView.buttonPressed!.contentVerticalAlignment = UIControl.ContentVerticalAlignment.fill
            editorView.contentView.buttonPressed!.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.fill
            editorView.contentView.buttonPressed!.imageView?.contentMode = .scaleAspectFill
            editorView.contentView.buttonPressed!.setImage(pickedImage, for: .normal)
        }

        picker.dismiss(animated: true, completion: nil)

    }

}
