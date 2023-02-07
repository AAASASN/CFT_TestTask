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
        label.textAlignment = .center
        label.text = "НАСТОЯЩИЙ МАТЕРИАЛ (ИНФОРМАЦИЯ) ПРОИЗВЕДЕН, РАСПРОСТРАНЕН И (ИЛИ) НАПРАВЛЕН ИНОСТРАННЫМ АГЕНТОМ (НАИМЕНОВАНИЕ, ФАМИЛИЯ, ИМЯ ОТЧЕСТВО (ПРИ НАЛИЧИИ), СОДЕРЖАЩАЯСЯ В РЕЕСТР ИНОСТРАННЫХ АГЕНТОВ) ЛИБО КАСАЕТСЯ ДЕЯТЕЛЬНОСТИ ИНОСТРАННОГО АГЕНТА (НАИМЕНОВАНИЕ, ФАМИЛИЯ, ИМЯ, ОТЧЕСТВО (ПРИ НАЛИЧИИ), СОДЕРЖАЩАЯСЯ В РЕЕСТР ИНОСТРАННЫХ АГЕНТОВ)"
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
