//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Media Davarkhah on 12/7/1399 AP.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

//
//    private var noteView: UIView = {
//        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//        return view
//    }()
    
 
    
    func configureCell(text : String){
 
        textLabel?.text = text
        contentView.backgroundColor = #colorLiteral(red: 0.1051029041, green: 0.1098239496, blue: 0.1184525415, alpha: 1)
//        contentView.addSubview(noteView)
//
//        noteView.translatesAutoresizingMaskIntoConstraints = false
//
//        noteView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
//        bottomAnchor.constraint(equalTo: noteView.bottomAnchor, constant: 20).isActive = true
//        noteView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//        trailingAnchor.constraint(equalTo: noteView.trailingAnchor, constant: 20).isActive = true
        
      

    }
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }

}
