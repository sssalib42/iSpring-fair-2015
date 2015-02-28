//
//  NotesViewController.swift
//  iSpring_Fair_2015
//
//  Created by Samer Salib on 2/23/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    // MARK: Properties
    
    //@IBOutlet var notesTextView: UITextView!
    //@IBOutlet var textViewBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var textViewBottomLayoutConstraint: NSLayoutConstraint!
    
    var existingInterview: NSManagedObject!
    var existingNote: String = ""
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if existingNote as String? != nil{
            notesTextView.text = existingNote
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Listen for changes to keyboard visibility so that we can adjust the text view accordingly.
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        
        if (existingInterview != nil){ //update the notes
            
            //refrence to app delegate
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            
                // ref to NS management context
            let context: NSManagedObjectContext = appDelegate.managedObjectContext!
            let entity = NSEntityDescription.entityForName("Interview", inManagedObjectContext: context)
            
            existingInterview.setValue(notesTextView.text, forKey: "notes")
            context.save(nil)
        }
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard Event Notifications
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        println("keyboard will show")
        keyboardWillChangeFrameWithNotification(notification, showsKeyboard: true)
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        println("keyboard will hide")
        keyboardWillChangeFrameWithNotification(notification, showsKeyboard: false)
    }
    
    // MARK: Convenience

    func keyboardWillChangeFrameWithNotification(notification: NSNotification, showsKeyboard: Bool) {
        let userInfo = notification.userInfo!
        
        let animationDuration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
        
        // Convert the keyboard frame from screen to view coordinates.
        let keyboardScreenBeginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue()
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        
        let keyboardViewBeginFrame = view.convertRect(keyboardScreenBeginFrame, fromView: view.window)
        let keyboardViewEndFrame = view.convertRect(keyboardScreenEndFrame, fromView: view.window)
        let originDelta = keyboardViewEndFrame.origin.y - keyboardViewBeginFrame.origin.y
        
        if showsKeyboard{
        // The text view should be adjusted, update the constant for this constraint.
        println("The constant before change: \(textViewBottomLayoutConstraint.constant)")
        textViewBottomLayoutConstraint.constant -= originDelta
        println("The constant after change: \(textViewBottomLayoutConstraint.constant))")
        }else{
            textViewBottomLayoutConstraint.constant = 0
        }
        view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(animationDuration, delay: 0, options: .BeginFromCurrentState, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        // Scroll to the selected text once the keyboard frame changes.
        let selectedRange = notesTextView.selectedRange
        notesTextView.scrollRangeToVisible(selectedRange)
    }
    
    
    
    
    // MARK: UITextViewDelegate
    
    func textViewDidBeginEditing(textView: UITextView) {
        // Provide a "Done" button for the user to select to signify completion with writing text in the text view.
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneBarButtonItemClicked")
        
        navigationItem.setRightBarButtonItem(doneBarButtonItem, animated: true)
    }
    
    // MARK: Actions
    
    func doneBarButtonItemClicked() {
        // Dismiss the keyboard by removing it as the first responder.
        notesTextView.resignFirstResponder()
        
        navigationItem.setRightBarButtonItem(nil, animated: true)
    }}
