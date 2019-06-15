//
//  AddToDoViewController.swift
//  ToDoApp
//
//  Created by Alexey Nikitin on 12/06/2019.
//  Copyright © 2019 Alexey Nikitin. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(with:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        textView.becomeFirstResponder()
    }
    
    // MARK: Actions
    
    @objc func keyboardWillShow(with notification: Notification){
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else {return}
        
        let keyboardHeight = keyboardFrame.cgRectValue.height + 16
        
         bottomConstraint.constant = keyboardHeight
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true )
        textView.resignFirstResponder()
    }
    
    @IBAction func done(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension AddToDoViewController: UITextViewDelegate{
    func textViewDidChangeSelection(_ textView: UITextView) {
        if doneButton.isHidden{
            textView.text.removeAll()
            textView.textColor = .white
            
            doneButton.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
