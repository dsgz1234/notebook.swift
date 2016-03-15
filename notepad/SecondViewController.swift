//
//  SecondViewController.swift
//  notepad
//
//  Created by Bob John on 10/3/2016.
//  Copyright © 2016 Bob John. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBOutlet var notetitle: UITextField!
    @IBOutlet var notes: UITextField!
    
    @IBAction func addBtnClick(sender: AnyObject) {
        noteManager.addNote(notetitle.text!, desc: notes.text!)
        self.view.endEditing(true)
        notetitle.text = ""
        notes.text = ""
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.reloadInputViews();
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
 }

