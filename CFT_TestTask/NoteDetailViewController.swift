//
//  NoteDetailViewController.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 04.02.2023.
//

import UIKit

class NoteDetailViewController: UIViewController {

    var noteId: String!
    
    var nameTextField: UITextField!
    var buttonsView: UIView!
    var textView: UITextView!
    var saveButtonItem: UIBarButtonItem!
    
    var boldTextButton: UIButton!
    var italicsTextButton: UIButton!
    var fontUpTextButton: UIButton!
    var fontDownTextButton: UIButton!
    
    var fontSet: FontSet!

    var noteStorage: NoteStorageProtocol!
    
    var tap: UITapGestureRecognizer! = nil

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteStorage = NoteStorageByCoreData() // NoteStorage()
                
        navigationItemsSettings()
        
        registerForKeyboardNotifications()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        viewSettings()
        
        fontSet = FontSet()
                
    }
    
    // MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        
        // если вызов экрана произошел при нажатии на ячейку то на экран был передан noteId
        // и если его удалось присвоить то
        if let someNoteId = noteId {
            
            // проверяем если был передан noteId  первичной ячейки
            if someNoteId == "1234567890" {
                
                // то настраиваем экран как экран создания заметки
                self.navigationItem.title = "Добавить"
                nameTextField.text = ""
                textView.text = ""
                
            } else {
                
                // иначе если был передан noteId  действующей ячейки
                // получаем из хранилища заметку по noteId
                if let someNote = noteStorage.getNoteFromStorageById(noteId: someNoteId) {
                    
                    // и если удалось получить настраиваем поля экрана данными
                    nameTextField.text = someNote.noteName
                    textView.text = someNote.noteText

                    // присваиваем свойству fontSet настройки отображения шрифтов
                    fontSet = someNote.fontSet
                    
                    // настраивам bold/regular у nameTextField и тени на кнопках (пока только для nameTextField )
                    if fontSet.noteNameBold {
                        
                        // шрифт bold
                        nameTextField.font = .boldSystemFont(ofSize: CGFloat(fontSet.noteNameFontSize.rawValue))
                        
                        // тени
                        self.boldTextButton.layer.shadowOpacity = 0.5
                        self.boldTextButton.layer.shadowOffset = CGSize(width: -3, height: 0)
                        
                    } else {
                        
                        // шрифт regular
                        nameTextField.font = .systemFont(ofSize: CGFloat(fontSet.noteNameFontSize.rawValue))
                        
                        // убираем тени
                        self.boldTextButton.layer.shadowOpacity = 0

                    }
                    
                }
            }

        } else {
            
            // если noteId равен nil значит настраиваем экран как экран создания новой заметки
            self.navigationItem.title = "Добавить"
            
            // генерим уникальный noteId для заметки
            noteId = UUID().uuidString
            
        }
        
    }
    
    
    // MARK: - navigationItemsSettings()
    func navigationItemsSettings() {
        
        self.navigationItem.title = "Редактор"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        saveButtonItem =  UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItem = saveButtonItem
        saveButtonItem.isEnabled = false
        
    }
    
    
    // MARK: - saveAction()
    @objc func saveAction() {
        
        // если тру значит был переход с начальной ячейки и нужно пересоздать уникальный noteId
        if noteId == "1234567890"  {
            noteId = UUID().uuidString
        }
        
        // создаем заметку заполняя ее значениями полей и настройками шрифтов
        let note = Note(noteId: noteId,
                        noteName: nameTextField.text ?? "error",
                        noteText: textView.text,
                        fontSet: self.fontSet,
                        priority: 1)
        
        // удаляем из хранилища заметку с noteId: "1234567890"
        noteStorage.deleteNoteFromStorageById(noteId: "1234567890")
        
        // сохраняем новую заметку
        noteStorage.setOneNoteToStorage(note: note)
        
        // после сохраниеия делаем кнопку сохранения не активной
        saveButtonItem.isEnabled = false
        
    }
    
    
// MARK: - viewSettings()
    func viewSettings() {
        
        // настройка всех полей экрана
        
        view.backgroundColor = .systemGray5
        
        nameTextField = UITextField(frame: CGRect(x: 16,
                                                  y: 160,
                                                  width: Int(self.view.frame.width) - 32,
                                                  height: 40))
        
        buttonsView = UIView(frame: CGRect(x: 16,
                                           y: 220,
                                           width: Int(self.view.frame.width) - 32,
                                                height: 20))
        
        textView = UITextView(frame: CGRect(x: 16,
                                            y: 260,
                                            width: Int(self.view.frame.width) - 32,
                                            height: Int(view.frame.maxY) - 360))
        
        view.addSubview(nameTextField)
        view.addSubview(buttonsView)
        view.addSubview(textView)
    
        nameTextField.layer.cornerRadius = 5
        buttonsView.layer.cornerRadius = 5
        textView.layer.cornerRadius = 5
        
        nameTextField.backgroundColor = .white
        nameTextField.placeholder = "введите название"
        nameTextField.indent(size: 10)
        
        // настройка вью на которой расположены кнопки управления щрифтами
        buttonViewSettings()
        
    }

}

// MARK: - buttonViewSettings()

// настройка вью на которой расположены кнопки управления щрифтами

extension NoteDetailViewController {
    
    func buttonViewSettings() {
        
        boldTextButtonSettings()
        italicsTextButtonSettings()
        fontUpTextButtonSettings()
        fontDownTextButtonSettings()
        
        buttonsView.addSubview(boldTextButton)
        buttonsView.addSubview(fontDownTextButton)
        buttonsView.addSubview(italicsTextButton)
        buttonsView.addSubview(fontUpTextButton)
        
        boldTextButton.backgroundColor = .white
        italicsTextButton.backgroundColor = .white
        fontUpTextButton.backgroundColor = .white
        fontDownTextButton.backgroundColor = .white
       
    }
    
    // MARK: - boldTextButtonSettings()
    func boldTextButtonSettings() {
        
        self.boldTextButton = UIButton(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: self.buttonsView.frame.size.width/4 + 5,
                                                     height: self.buttonsView.frame.size.height),
                                       
                                       primaryAction: UIAction(handler: { _ in
            
            // при нажатии на кнопку изменяется шрифт на bold/regular и добавляется/удаляется тень у кнопки
            if self.nameTextField.isFirstResponder {
                
                if self.fontSet.noteNameBold {
                    self.fontSet.noteNameBold.toggle()
                    self.nameTextField.font = .systemFont(ofSize: CGFloat(self.fontSet.noteNameFontSize.rawValue), weight: .regular)
                    self.boldTextButton.layer.shadowOpacity = 0
                }
                else {
                    self.fontSet.noteNameBold.toggle()
                    self.nameTextField.font = .systemFont(ofSize: 14, weight: .bold)
                    self.boldTextButton.layer.shadowOpacity = 0.5
                    self.boldTextButton.layer.shadowOffset = CGSize(width: -3, height: 0)
                }

            }
            
        }))
        
        // отрисовка кнопки
        boldTextButton.layer.borderColor = UIColor.blue.cgColor
        boldTextButton.layer.borderWidth = 1
        boldTextButton.layer.cornerRadius = 5
        
        let titleImage = UIImageView(image: UIImage(systemName: "bold"))
        titleImage.frame.size.height = 15
        titleImage.frame.size.width = 15
        titleImage.center = boldTextButton.center
        boldTextButton.addSubview(titleImage)

    }
    
    
    // реализация работы кнопки курсва
    func italicsTextButtonSettings() {
        
        italicsTextButton = UIButton(frame: CGRect(x: self.buttonsView.frame.size.width/4,
                                                   y: 0,
                                                   width: (self.buttonsView.frame.size.width)/4 + 2,
                                                   height: self.buttonsView.frame.size.height), primaryAction: UIAction(handler: { _ in

            // здесь будет раелизация нажатия на кнопку

        
//            if self.nameTextField.isFirstResponder {
//
//                if self.nameTextField.font != .italicSystemFont(ofSize: 14) {
//                    self.nameTextField.font = .italicSystemFont(ofSize: 14)
//                    self.italicsTextButton.layer.shadowOpacity = 0.5
//                    self.italicsTextButton.layer.shadowOffset = CGSize(width: 1, height: 0)
//                } else {
//                    self.nameTextField.font = .systemFont(ofSize: 14)
//                    self.italicsTextButton.layer.shadowOpacity = 0
//
//                }
//
//            }
//
//            if self.textView.isFirstResponder {
//
//                if self.textView.font != .italicSystemFont(ofSize: 14) {
//                    self.textView.font = .italicSystemFont(ofSize: 14)
//                    self.italicsTextButton.layer.shadowOpacity = 0.5
//                    self.italicsTextButton.layer.shadowOffset = CGSize(width: 1, height: 0)
//                } else {
//                    self.textView.font = .systemFont(ofSize: 14 )
//                    self.italicsTextButton.layer.shadowOpacity = 0
//
//                }
//
//            }

        }))
        
        italicsTextButton.layer.borderColor = UIColor.blue.cgColor
        italicsTextButton.layer.borderWidth = 1
        
        let titleImage = UIImageView(image: UIImage(systemName: "italic"))
        titleImage.frame.size.height = 15
        titleImage.frame.size.width = 15
        titleImage.center.x = italicsTextButton.bounds.maxX/2
        titleImage.center.y = italicsTextButton.bounds.maxY/2

        italicsTextButton.addSubview(titleImage)
        
    }
    
    
    
    func fontUpTextButtonSettings() {
        
        fontUpTextButton = UIButton(frame: CGRect(x: self.buttonsView.frame.size.width/2,
                                                  y: 0,
                                                  width: self.buttonsView.frame.size.width/4,
                                                  height: self.buttonsView.frame.size.height), primaryAction: UIAction(handler: { _ in
            
            // здесь будет раелизация нажатия на кнопку
        }))
        
        fontUpTextButton.layer.borderColor = UIColor.blue.cgColor
        fontUpTextButton.layer.borderWidth = 1
        
        let titleImage = UIImageView(image: UIImage(systemName: "chevron.up"))
        titleImage.frame.size.height = 10
        titleImage.frame.size.width = 20
        titleImage.center.x = fontUpTextButton.bounds.maxX/2
        titleImage.center.y = fontUpTextButton.bounds.maxY/2

        fontUpTextButton.addSubview(titleImage)
    }
    
    
    func fontDownTextButtonSettings() {
        fontDownTextButton = UIButton(frame: CGRect(x: self.buttonsView.frame.size.width/4 + self.buttonsView.frame.size.width/2 - 5,
                                                    y: 0,
                                                    width: self.buttonsView.frame.size.width/4 + 5,
                                                    height: self.buttonsView.frame.size.height), primaryAction: UIAction(handler: { _ in
            
            // здесь будет раелизация нажатия на кнопку
        }))
        
        fontDownTextButton.layer.borderColor = UIColor.blue.cgColor
        fontDownTextButton.layer.borderWidth = 1
        fontDownTextButton.layer.cornerRadius = 5
        
        let titleImage = UIImageView(image: UIImage(systemName: "chevron.down"))
        titleImage.frame.size.height = 10
        titleImage.frame.size.width = 20
        titleImage.center.x = fontDownTextButton.bounds.maxX/2
        titleImage.center.y = fontDownTextButton.bounds.maxY/2

        fontDownTextButton.addSubview(titleImage)
    }
    
}


// управление клавиатурой
// MARK: - keyboard
extension NoteDetailViewController {
    
    // активируем режим отслеживания нажатия на view
    func registerTapGestureRecognizerForHideKeyboard() {
        view.addGestureRecognizer(tap)
        viewWillLayoutSubviews()
    }

    // скрываем клавиатуру с view и удаляем gestureRecognizers
    @objc func dismissKeyboard() {
        // скрываем клавиатуру
        view.endEditing(true)
        view.removeGestureRecognizer(tap)
    }
    
    // этот метод будет вызван в viewDidLoad, он регистрирует наблюдателей которые...
    func registerForKeyboardNotifications() {

        // ... будет реагировать на появление клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // ... будет реагировать на начало изчезновения клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    // удаление наблюдателей когда они уже не нужны
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // перед тем как клавиатура появляется изменяется размер textView
    @objc func kbWillShow(_ notification: Notification) {

        saveButtonItem.isEnabled = true

        // запрашиваем параметры клавиатуры
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                
        textView.frame.size.height = view.frame.maxY - kbFrameSize.height - 280

        // в тот момент когда появилась клавиатура зарегистрируется нажатие UITapGestureRecognizer
        registerTapGestureRecognizerForHideKeyboard()

    }

    // после того как клавиатура скрыта размер textView становится прежним
    @objc func kbWillHide() {
        
        textView.frame.size.height = CGFloat(Int(view.frame.maxY) - 360)

    }
    
}


// расширение для отсупа UITextField
// MARK: - UITextField extension
extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
