//
//  NoteViewController.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 03.02.2023.
//

import UIKit


class NoteViewController: UIViewController {

    var tableView: UITableView!
    var noteStorage: NoteStorageProtocol!
    var addButtonItem: UIBarButtonItem!
    var editingButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteStorage = NoteStorage()
        viewSettings()
        tableViewViewSettings()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.isEditing = false
        tableView.reloadData()
        
    }

}


// MARK: - viewSettings()
extension NoteViewController {

    func viewSettings() {
        
        view.backgroundColor = .systemGray5
        
        self.navigationItem.title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        addButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        
        editingButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction))
        
        self.navigationItem.rightBarButtonItem = addButtonItem
        self.navigationItem.leftBarButtonItem =  editingButtonItem
        
    }
    
    // MARK: - addAction()
    @objc func addAction() {
        
        let addNoteViewController = NoteDetailViewController()
        self.navigationController?.pushViewController(addNoteViewController, animated: true)
  
    }
    
    // MARK: - editAction()
    @objc func editAction() {
        
        tableView.isEditing = !tableView.isEditing
  
    }
    
}


// MARK: - tableViewViewSettings()
extension NoteViewController {
    
    func tableViewViewSettings()  {
                
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        self.tableView.backgroundColor = .systemGray5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
}


// MARK: - DataSource, Delegate
extension NoteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noteStorage.getNotesFromStorage().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = NoteTableViewCell()
        cell.noteNameLabel.text = noteStorage.getNotesFromStorage()[indexPath.row].noteName
        
        // настройка шрифтов bold/regular
        if noteStorage.getNotesFromStorage()[indexPath.row].fontSet.noteNameBold {
            cell.noteNameLabel.font = .boldSystemFont(ofSize: CGFloat(noteStorage.getNotesFromStorage()[indexPath.row].fontSet.noteNameFontSize.rawValue))
        } else {
            cell.noteNameLabel.font = .systemFont(ofSize: CGFloat(noteStorage.getNotesFromStorage()[indexPath.row].fontSet.noteNameFontSize.rawValue)) 
        }
        
        // отображение приоритетов пока не реализована
        //cell.notePriorityLabel.text = String(noteStorage.getNotesFromStorage()[indexPath.row].priority)
        
        cell.noteTextLabel.text = noteStorage.getNotesFromStorage()[indexPath.row].noteText
                                    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let noteDetailViewController = NoteDetailViewController()
        noteDetailViewController.noteId = noteStorage.getNotesFromStorage()[indexPath.row].noteId
        self.navigationController?.pushViewController(noteDetailViewController, animated: true)
        
    }
    
    // метод для редактирования ячеек в таблице, в данном случае будет реализована возможность удалять ячейку свайпом справо налево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                
        //  действие удаления
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") { _,_,_ in

            // удаляем конкретную заметку из хранилища
            let noteArray = self.noteStorage.getNotesFromStorage()
            self.noteStorage.deleteNoteFromStorageById(noteId: noteArray[indexPath.section].noteId)

            // обновляем таблицу
            tableView.reloadData()
        }
        
        
        // формируем экземпляр UISwipeActionsConfiguration
        let actions = UISwipeActionsConfiguration(actions: [actionDelete] )
        return actions
    }
    
    // перемещение ячейки
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        noteStorage.movingNoteInStorage(sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
        tableView.reloadData()

    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }

}


