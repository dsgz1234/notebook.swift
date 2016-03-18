//
//  SecondViewController.swift
//  notepad
//
//  Created by Bob John on 10/3/2016.
//  Copyright © 2016 Bob John. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,UIAlertViewDelegate{
    
    @IBOutlet var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    // TODO: test
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
    
    //    @IBOutlet var notes: UITextView!
    
    @IBAction func addBtnClick(sender: AnyObject) {
        if (notetitle.text?.isEmpty == false || notes.text?.isEmpty == false){
            noteManager.addNote(notetitle.text!, desc: notes.text! ,image: self.image.image!)
            self.view.endEditing(true)
            notetitle.text = ""
            notes.text = ""
            self.tabBarController?.selectedIndex = 0
            self.tabBarController?.reloadInputViews();
        }else{
            let alert = UIAlertView(title: "不能为空", message: "内容不能为空", delegate: self, cancelButtonTitle: "我保证不再浪费空间");
            alert.show()
        }
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        notetitle.text = "😊"
        print(buttonIndex)
    }
    @IBAction func pickImagePressed(sender: AnyObject) {
        let tag = sender.tag
        let vc = UIImagePickerController();
        vc.sourceType = (tag==0 ? UIImagePickerControllerSourceType.PhotoLibrary : UIImagePickerControllerSourceType.Camera)
        self.presentViewController(vc, animated: true, completion: nil)
        vc.delegate = self
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.image.image=image;
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

