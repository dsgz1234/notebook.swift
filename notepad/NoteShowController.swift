//
//  NoteShowController.swift
//  notepad
//
//  Created by Bob John on 14/3/2016.
//  Copyright © 2016 Bob John. All rights reserved.
//

import UIKit
import Foundation

class NoteShowController : UIViewController,UITextViewDelegate{
    @IBOutlet var notetitle: UITextView!
    @IBOutlet var notefild: UITextView!
    var element:note?=nil
    
    override func viewDidLoad() {
        //        if let index = (self.presentingViewController as! FirstViewController).selectRow{
        //            let thenote : note = noteManager.notes[index];
        //            inittext(thenote.name, fild: thenote.note);
        //        }
        //        if let temp=element{
        settext(element!)
        //        }
        
    }
    
    func settext(fild:note){
        self.notetitle.text=fild.name
        self.notefild.text=fild.note
    }
    func textViewDidBeginEditing(textView: UITextView) {
        //        self.element?.note = textView.
    }
    func textViewDidChange(textView: UITextView) {
        if textView.restorationIdentifier == "title"{
            self.element?.name=textView.text;
        }
        if textView.restorationIdentifier == "fild"{
            self.element?.note=textView.text;
        }
    }
    
    
}
