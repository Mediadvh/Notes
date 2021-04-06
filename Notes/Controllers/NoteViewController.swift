//
//  NoteViewController.swift
//  Notes
//
//  Created by Media Davarkhah on 12/8/1399 AP.
//

import UIKit

class NoteViewController: UIViewController {

    // this closure will reload the tableView in the HomeViewController
    // the closure's body will be set in the HomeViewController but will be used here
    var reloadTableView: (()->())?
    
    // if the user selected a particular note this variable will be set to true
    // if the user made a new note this variable will be set to false
    var isInEditMode : Bool?
    
    // if the user selected a particular note this variable will contain that Note
    var noteToEdit: Note?
    
    
    private var textView:UITextView = {
        
        let textView = UITextView()
        textView.tintColor = .systemYellow
        textView.sizeToFit()
        textView.font = UIFont(name: "ArialMT", size: 20)
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
        
        // wthe keyboard will show automatically when a note is opened
        textView.becomeFirstResponder()
        
        // the user might select an existing node rather than a make new one
        // in this case we want the TextView to contain the text of the selected Note
        guard let noteToEdit = noteToEdit else{return}
        textView.text = noteToEdit.text
        
        

      
    }

    
    
    override func viewDidLayoutSubviews() {
        
        textView.frame = view.frame
    }
   
        
    override func viewWillDisappear(_ animated: Bool) {
       
        
        
        // if it is in Edit mode we want to replace the last note's text with the new one
       if(isInEditMode!){
        
        
        guard let noteToEdit = noteToEdit else {return}
        
        // if the note isn't the same as before
        
        guard noteToEdit.text != textView.text  else {return}
        // if the note is empty we want it to be deleted
        guard !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            DataSaver.context.delete(noteToEdit)
            DataSaver.save()
            if let reloadTableView = reloadTableView{
                    reloadTableView()
            }
            return
        }
        noteToEdit.text = textView.text
        // save to core data
        DataSaver.save()
            
        }
            
       // if it is not in the Edit mode, we want to make a new note
        else{

            // if the note is empty we don't want it to be saved
            guard !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                return
            }
            
           
            let newNote = Note(context: DataSaver.context)
            newNote.text = textView.text
            
            // save to core data
            DataSaver.save()
        }
       
        
        if let reloadTableView = reloadTableView{
                reloadTableView()
        }
   }
   



}
