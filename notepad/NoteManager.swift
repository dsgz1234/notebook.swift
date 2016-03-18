//
//  NoteManager.swift
//  notepad
//
//  Created by Bob John on 10/3/2016.
//  Copyright © 2016 Bob John. All rights reserved.
//

import Foundation
import UIKit
import SQLite

var noteManager : NoteManager = NoteManager ()

let path = NSSearchPathForDirectoriesInDomains(
    .DocumentDirectory, .UserDomainMask, true
    ).first!

let db = try! Connection("\(path)/db.sqlite3")
let notestable = Table("users")
let id = Expression<Int64>("id")
let notetitle = Expression<String>("notetitle")
let notedata = Expression<String>("notedata")
let noteimg = Expression<UIImage?>("img")



extension UIImage: Value {
    public class var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    public class func fromDatatypeValue(blobValue: Blob) -> UIImage {
        return UIImage(data: NSData.fromDatatypeValue(blobValue))!
    }
    public var datatypeValue: Blob {
        return UIImagePNGRepresentation(self)!.datatypeValue
    }
    
}

class NoteManager: NSObject {
    var notes = [note]();
    var path = NSSearchPathForDirectoriesInDomains(
        .DocumentDirectory, .UserDomainMask, true
        ).first!
    
    
    func initdb(){
        try! db.run(notestable.create(ifNotExists: true){ t in
        t.column(id, primaryKey: .Autoincrement)
        t.column(notetitle)
        t.column(notedata)
        t.column(noteimg)
        })
    }
    
    
    func addNote(name: String, desc: String, image: UIImage ) {
        let insert = notestable.insert(notetitle <- name, notedata <- desc,noteimg <- image)
        //print(insert.asSQL());
        do{
            let rowid = try db.run(insert)
            notes.append(note(name: name, note: desc,tag:rowid,image:image))
            
            print(rowid)
        }catch{
            
        }
    }
    
    func deleteNote(index:Int){
        let tag = notes[index].tag;
        notes.removeAtIndex(index)
        let alice = notestable.filter(id==Int64(tag))
        try! db.run(alice.delete())
    }
    
    func update(update:note){
        try! db.run(notestable.filter(id==Int64(update.tag)).update(notetitle <- update.name,notedata <- update.note,noteimg <- update.image))
    }
    
    func loadData(){
        initdb()
        notes.removeAll(keepCapacity: false)
        for user in try! db.prepare(notestable) {
            notes.append(note(name: user[notetitle], note: user[notedata],tag:user[id],image: user.get(noteimg)))
        }
    }
    
}
struct note{
    var name:String = "new note";
    var note:String = "new note";
    var tag:Int64;
    var image: UIImage?;
}

