//
//  InfoViewController.swift
//  CFT_TestTask
//
//  Created by Александр Мараенко on 03.02.2023.
//

import UIKit

class InfoViewController: UIViewController {

    //var localVarPost = SomePost()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: self.view.frame.width - 32, height: self.view.frame.height))
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        // label.textAlignment = .center
        label.text = """
        Задание:

        Необходимо создать приложение Заметки на языке программирования Swift.Приложение может быть сделано как в консольном виде, так и в виде приложения на macOS, iOS.

        Строгих требований к реализации и функциональности нет, будьте творческими! Нам главное посмотреть, как вы подходите к задаче и какие инструменты в
        разработке используете.

        Обязательные требования:
        - Создание одной простейшей заметки только с текстом;
        - Редактирование заметки в окне собственного приложения;
        - Сохранение заметки между сеансами приложения, в любом формате;
        - При первом запуске приложение должно иметь одну заметку с текстом.

        Желательно:
        - Создание нескольких заметок в приложении;
        - Выводить список существующих заметок;
        - Возможность редактирования любой заметки из списка;
        - Удаление заметок;
        - Также сохранять все заметки между сеансами.

        Идеи для улучшения:
        - Возможность выделять текст курсивом, жирным и т. п.;
        - Менять шрифт и размер текста;
        - Вставка картинок.

        Уделяйте внимание качеству кода, который вы пишете, а также стилистическому оформлению. Учитывайте то, что ваш продукт может стать популярным, а над исходным кодом будут работать другие разработчики. Удачи!


        Описпание решения:

        - UI приложения основан на UIViewController, UITableView, UITextField, UITextView;
        - Реализовано удаление и сортировки заметок с применением UITableViewDataSource и UITableViewDelegate;
        - Настройка шрифта реализована только для UITextField;
        - В качестве постоянного хранилища данных использован UserDefaults.
"""
        view.addSubview(label)
//
//        self.navigationItem.title = "Информация"
//        self.navigationItem.largeTitleDisplayMode = .always
//        self.navigationItem.backButtonDisplayMode = .minimal
//
//        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonItemAction))
//        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    
    
//    @objc func barButtonItemAction() {
//        self.present(createInfoViewController(), animated: true)
//    }
//
//     func createInfoViewController() -> UIViewController {
//        let infoViewController = InfoViewController()
//        return infoViewController
//    }

}
