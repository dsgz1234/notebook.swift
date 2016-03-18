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
    
    @IBOutlet var notetitle: UITextField!
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
        notetitle.layer.borderWidth = 1.2;
        notetitle.layer.borderColor = UIColor.grayColor().CGColor
        notetitle.layer.cornerRadius = 10.0
//        notetitle.layer.masksToBounds = true
        notefild.layer.borderWidth = 1.2;
        notefild.layer.borderColor = UIColor.grayColor().CGColor
        notefild.layer.cornerRadius = 10.0
//        notefild.layer.masksToBounds = true

        
    }
    
    func settext(fild:note){
        self.notetitle.text=fild.name
        self.notefild.text=fild.note
        
        
        //let image = UIImageView(image: fild.image)
        //self.notefild.addSubview(image)
    }
    func textViewDidChange(textView: UITextView) {
        if textView.restorationIdentifier == "title"{
            self.element?.name=textView.text;
        }
        if textView.restorationIdentifier == "fild"{
            self.element?.note=textView.text;
        }
    }
    @IBAction func backToDetial(segue:UIStoryboardSegue){
        dismissViewControllerAnimated(true, completion: nil)
        //segue.sourceViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let iv = UIImageView(image: element?.image)
        //iv.contentMode=UIViewContentMode.ScaleAspectFill
        (segue.destinationViewController as UIViewController).view.subviews[0].addSubview(iv)

    }
    
    
}
