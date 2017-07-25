//
//  ViewController.swift
//  DearDude
//
//  Created by Kevin Remigio on 7/24/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textView:UITextView? = nil
    var bgView: UIImageView? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bgFrame:CGRect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        bgView = UIImageView(frame: bgFrame)
        bgView?.image = UIImage(named: "a")
        bgView?.contentMode = .scaleAspectFill
        view.addSubview(bgView!)
        
        let textFrame:CGRect = CGRect(x: 20, y: 40, width: view.frame.width - 40 , height: view.frame.height - 80)
        textView = UITextView(frame: textFrame)
        textView?.delegate = self
        textView?.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        textView?.textColor = UIColor.black
        textView?.font = UIFont(name: "Helvetica", size: 16)
        textView?.text = "..."
        textView?.layer.cornerRadius = 5
        view.addSubview(textView!)
        
        hideKeyboardWhenTappedAround()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(gestureRecognizer:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func handleSwipe(gestureRecognizer: UIPanGestureRecognizer) {
        print("hello dude")
        let entryView:EntryViewController = EntryViewController()
        //self.present(entryView, animated: true, completion: nil)
        self.presentDetail(entryView)
        
    }
    func keyboardWillAppear(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            textView?.frame.size.height -= keyboardHeight
        }
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        // Do something here
        textView?.frame.size.height = view.frame.height - 80
    }

}
extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.1
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.1
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
