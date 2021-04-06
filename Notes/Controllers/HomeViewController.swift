//
//  ViewController.swift
//  Notes
//
//  Created by Media Davarkhah on 12/5/1399 AP.
//

import UIKit

class HomeViewController: UIViewController{
    
    
    var notes = [Note]()
    
    private var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
       
        return searchBar
    }()
    
    private var addButton:UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "square.and.pencil")
        button.tintColor = .systemYellow
        button.action = #selector(didTapAdd)
       
        return button
    }()
    
    private var tableView:UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(NoteTableViewCell.self, forCellReuseIdentifier: String(describing: NoteTableViewCell.self))
        
       return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async{
            self.tableView.reloadData()}
        title = "Notes"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        addButton.target = self
        navigationItem.rightBarButtonItem = addButton
     
        // get data
        DataFetcher.fetchNotes(into: &notes)
       
        // add search bar as header to the tableview
        searchBar.frame = CGRect(x: 0, y: 0, width: tableView.width, height: 44)
        self.tableView.tableHeaderView = searchBar
//        tableView.layer.cornerRadius = 10
//        tableView.layer.masksToBounds = true
        
        
        
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var contentOffset: CGPoint = self.tableView.contentOffset
        contentOffset.y += (self.tableView.tableHeaderView?.frame)!.height
        self.tableView.contentOffset = contentOffset
    }
    
    @objc func didTapAdd(){
        
        let vc = NoteViewController()
        vc.isInEditMode = false
        navigationController?.pushViewController(vc, animated: true)
        vc.reloadTableView = { [weak self] in
                DispatchQueue.main.async{
                DataFetcher.fetchNotes(into: &(self!.notes))
                self?.tableView.reloadData()
               
            }
        }
    }
    override func viewDidLayoutSubviews() {
        
        tableView.frame = CGRect(x: view.left + 20, y: view.right - 300, width: view.width - 40, height: view.height)
        
    }
    

}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as! NoteTableViewCell
        let text = notes[indexPath.row].text
        cell.configureCell(text: text!)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { (UIContextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            
            // perform the delete action
            let alert = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this note?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alertaction) in
                
               
                
                // pull out the selected object
                let noteToDelete = self.notes[indexPath.row]
                
                // delete selected object
                DataSaver.context.delete(noteToDelete)
                DataSaver.save()
                
                // delete it from the array
                self.notes.remove(at: indexPath.row)
                
                // Finally delete the row that contains it
                tableView.deleteRows(at: [indexPath], with: .fade)

                
                actionPerformed(true)
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in
               
                actionPerformed(false)
            }
           
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
        
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = NoteViewController()
        
        
       
        navigationController?.pushViewController(vc, animated: true)
        
        
        vc.isInEditMode = true
        vc.noteToEdit = notes[indexPath.row]

        vc.reloadTableView = { [weak self] in
            DispatchQueue.main.async{
            DataFetcher.fetchNotes(into: &(self!.notes))
            self?.tableView.reloadData()
            }
        }
        
        

    }
   
   
}

