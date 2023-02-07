//
//  NoteTableViewCell.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 03.02.2023.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    
    var noteNameLabel: UILabel!
    var notePriorityLabel: UILabel!
    var noteTextLabel: UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        setting()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setting()  {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        
        noteNameLabel = UILabel(frame: .zero)
        notePriorityLabel = UILabel(frame: .zero)
        noteTextLabel = UILabel(frame: .zero)
        
        noteNameLabel.translatesAutoresizingMaskIntoConstraints = false
        notePriorityLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(noteNameLabel)
        contentView.addSubview(notePriorityLabel)
        contentView.addSubview(noteTextLabel)
        
        noteTextLabel.numberOfLines = 0
        
        noteNameLabel.font = .systemFont(ofSize: 17, weight: .medium)
        noteTextLabel.font = .systemFont(ofSize: 14, weight: .light)
        
        
        noteNameLabel.textColor = .black
        noteTextLabel.textColor = .gray

        NSLayoutConstraint.activate([noteNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
                                     noteNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
                                     noteNameLabel.trailingAnchor.constraint(equalTo: notePriorityLabel.leadingAnchor, constant: -20),
                                     noteNameLabel.heightAnchor.constraint(equalToConstant: 20),
                                     
                                     notePriorityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
                                     notePriorityLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
                                     notePriorityLabel.heightAnchor.constraint(equalToConstant: 20),
                                     
                                     noteTextLabel.topAnchor.constraint(equalTo: noteNameLabel.bottomAnchor, constant: 20),
                                     noteTextLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
                                     noteTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
                                     noteTextLabel.heightAnchor.constraint(equalToConstant: 50),
                                     noteTextLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
                                     
                                    ])
        
    }
    
}


