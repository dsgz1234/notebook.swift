//
//  NoteShowController.swift
//  notepad
//
//  Created by Bob John on 14/3/2016.
//  Copyright © 2016 Bob John. All rights reserved.
//

import UIKit
import Foundation

class NoteShowController : UIViewController{
    @IBOutlet var notetitle: UITextView!
    @IBOutlet var notefild: UITextView!
    override func viewDidLoad() {
        if let index = (self.presentingViewController as! FirstViewController).selectRow{
            let thenote : note = noteManager.notes[index];
            inittext(thenote.name, fild: thenote.note);
        }
        
    }
    
    func inittext(title:String,fild:String){
        self.notetitle.text=title
        self.notefild.text=fild
    }
    @IBAction func backToView(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
