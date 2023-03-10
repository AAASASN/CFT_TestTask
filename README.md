<h1 align="center"> Тестовое задание на стажировку в ЦФТ
  
<h2 align="center">Центр Финансовых Технологий - https://team.cft.ru/start/school/ios

# Задание: 

Необходимо создать приложение Заметки на языке программирования Swift. Приложение может быть сделано как в консольном виде, так и в виде приложения на macOS, iOS.

Требования:
- Создание одной простейшей заметки только с текстом;
- Редактирование заметки в окне собственного приложения;
- Сохранение заметки между сеансами приложения, в любом формате;
- При первом запуске приложение должно иметь одну заметку с текстом;
- Создание нескольких заметок в приложении;
- Выводить список существующих заметок;
- Возможность редактирования любой заметки из списка;
- Удаление заметок;
- Также сохранять все заметки между сеансами;
- Возможность выделять текст курсивом, жирным и т. п.;
- Менять шрифт и размер текста;
- Вставка картинок.


# Описание решения: 

- Навигация между экранами основана на UINavigationController, UITabBarController, UIViewController;
- Для работы с заметками использованы UITableView, UITextField, UITextView;
- Интерфейс сверстан в коде, без использования Storyboard;
- Отображение, взаимодействие, удаление и сортировка заметок реализовано при помощи UITableView и его протоколов UITableViewDataSource и UITableViewDelegate;
- Настройка шрифта реализована только для зоголовка заметки - UITextField;
- В первоначальном варианте в качестве постоянного хранилища данных использован UserDefaults - ветка - feature/branchByUserDefaults, в последнем варианте, в main-ветке реализовано хранилище на CoreData. Взаимодействие контроллера с моделью описано через протокол NoteStorageProtocol, поэтому для перехода на CoreData поторебовалось реализовать в новом хранилище его методы, а в котроллерах NoteViewController и NoteDetailViewController заменить тип с NoteStorage на NoteStorageByCoreData. Этот пример реализует один из принциав SOLID,  D - инверсирование зависимостей. Сам способ хранения через CoreData в данном случае не очень удачен и по сути повторяет подход показанный в примере с UserDefaults. В хранилище NoteStorageByCoreData просто берется массив, переводится в Data при помощи JSON и засовывается в единственное свойство которое есть у Энтити. То есть не идет речь ни о каком хранении элементов массива построчно в SQLite таблице, никаких зависимостей и всех вытекающих приемуществ реляционных баз данных. Реализовать такое довольно сложно, поскольку сама таблица больше напоминает Set и хранит в себе уникальные неупорядоченные элементы. Для этого нужно добавлять в энтити допольнительное свойство-индекс и следить за тем чтобы индексы обновлялись - то есть по сути вручную реализовывать массив на основе сета. Для удобного хранения массивов в CoreData в качестве датасурса UITableView можно использовать класс NSFetchResultsController и протокол NSFetchedResultsControllerDelegate, о нем в следующих версиях проекта.


 
<img src="Screen/Screenshot at Feb 10 02-53-36.png" alt="Задана ширина и высота" >

