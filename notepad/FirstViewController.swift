//
//  FirstViewController.swift
//  notepad
//
//  Created by Bob John on 10/3/2016.
//  Copyright © 2016 Bob John. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController{
    @IBOutlet var tableview: UITableView!
    var refreshCTL = UIRefreshControl()
    var selectRow:Int?=nil;
    
    let sb = UIStoryboard(name: "Main", bundle:nil)
    var vc: UIViewController?=nil;
    
    override func viewDidAppear(animated: Bool) {
        //noteManager.addNote("123", desc: "443");
        vc = sb.instantiateViewControllerWithIdentifier("NoteShowController")
        refresh();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refreshCTL.addTarget(self, action: "refresh",
            forControlEvents: UIControlEvents.ValueChanged)
        refreshCTL.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableview.addSubview(refreshCTL)
        noteManager.initdb()
        noteManager.loadData()
    }
    func refresh(){
        tableview.reloadData();
        self.refreshCTL.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return noteManager.notes.count;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        
        cell.textLabel?.text = noteManager.notes[indexPath.row].name
        cell.detailTextLabel?.text = noteManager.notes[indexPath.row].note
        //        cell.tag = noteManager.notes[indexPath.row].tag
        return cell
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            noteManager.deleteNote(indexPath.row)
        }
        
        tableview.reloadData()
    }
    @IBAction func backToView(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
        let update = (segue.sourceViewController as! NoteShowController).element
        noteManager.update(update!)
        noteManager.loadData()
    }
    //on touch
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //        sb.in
        //        var thenote : note = noteManager.notes[indexPath.row];
        //        noteshow.inittext(thenote.name, fild: thenote.note)
        //        selectRow=indexPath.row;
        //        self.navigationController?.presentViewController(vc!, animated: true, completion: nil)
        //        self.presentViewController(vc!, animated: true, completion: nil)
        self.performSegueWithIdentifier("edit", sender: self)
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.tableView.indexPathForSelectedRow
        let element = noteManager.notes[(indexPath?.row)!]
        let elementDetailViewController = segue.destinationViewController as! NoteShowController
        elementDetailViewController.element=element;
    }
    
}
