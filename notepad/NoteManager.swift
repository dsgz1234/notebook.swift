//
//  NoteManager.swift
//  notepad
//
//  Created by Bob John on 10/3/2016.
//  Copyright © 2016 Bob John. All rights reserved.
//

import Foundation
import SQLite

var noteManager : NoteManager = NoteManager ()

let path = NSSearchPathForDirectoriesInDomains(
    .DocumentDirectory, .UserDomainMask, true
    ).first!

let db = try! Connection("\(path)/db.sqlite3")

class NoteManager: NSObject {
    var notes = [note]();
    var path = NSSearchPathForDirectoriesInDomains(
        .DocumentDirectory, .UserDomainMask, true
        ).first!
    let notestable = Table("users")
    let id = Expression<Int64>("id")
    let notetitle = Expression<String>("notetitle")
    let notedata = Expression<String>("notedata")
    
    
    func initdb(){
        try! db.run(notestable.create(ifNotExists: true){ t in
            t.column(id, primaryKey: .Autoincrement)
            t.column(notetitle)
            t.column(notedata)
            })
        
    }
    
    
    func addNote(name: String, desc: String) {
        initdb();
        let insert = notestable.insert(notetitle <- name, notedata <- desc)
        print(insert.asSQL());
        do{
            let rowid = try! db.run(insert)
            notes.append(note(name: name, note: desc,tag:rowid))
            
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
        try! db.run(notestable.filter(id==Int64(update.tag)).update(notetitle <- update.name,notedata <- update.note))
    }
    
    func loadData(){
        notes.removeAll(keepCapacity: false)
        for user in try! db.prepare(notestable) {
            notes.append(note(name: user[notetitle], note: user[notedata],tag:user[id]))
        }
    }
    
}
struct note{
    var name:String = "new note";
    var note:String = "new note";
    var tag:Int64;
}

