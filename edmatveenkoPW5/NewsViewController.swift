//
//  NewsViewController.swift (View)
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 17.12.2024.
//

import UIKit

protocol NewsView: AnyObject {
    func displayNews(_ news: [ArticleModel])
    func showError(_ message: String)
}

class NewsViewController: UIViewController, NewsView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var presenter: NewsPresenter!
    var tableView: UITableView!
    var news: [ArticleModel] = []
    
    // MARK: - Constants
    private let cellIdentifier = "ArticleCell"
    private let gradientStartColor = UIColor.systemBlue.cgColor
    private let gradientEndColor = UIColor.systemPurple.cgColor
    private let gradientStartPoint = CGPoint(x: 0, y: 0)
    private let gradientEndPoint = CGPoint(x: 1, y: 1)
    
    private let topPadding: CGFloat = 0
    private let bottomPadding: CGFloat = 0
    private let leftPadding: CGFloat = 0
    private let rightPadding: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupTableView()
        presenter.fetchNews()
    }

    // MARK: - Setup Methods
    private func setupGradientBackground() {
        // Создаем и настраиваем градиентный слой
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [gradientStartColor, gradientEndColor]
        gradientLayer.startPoint = gradientStartPoint
        gradientLayer.endPoint = gradientEndPoint
        
        // Вставляем градиентный слой в слой view
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupTableView() {
        // Создаем таблицу и настраиваем ее делегаты
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.backgroundColor = UIColor.clear // Прозрачный фон для таблицы
        view.addSubview(tableView)

        // Используем методы из UIView+Pin для установки ограничений
        tableView.pinTop(to: view, topPadding)
        tableView.pinLeft(to: view, leftPadding)
        tableView.pinRight(to: view, rightPadding)
        tableView.pinBottom(to: view, bottomPadding)
    }

    // MARK: - NewsView Protocol Methods
    func displayNews(_ news: [ArticleModel]) {
        self.news = news
        DispatchQueue.main.async {
            self.tableView.reloadData() // Обновляем таблицу после получения данных
        }
    }

    func showError(_ message: String) {
        print(message)
    }

    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count // Возвращаем количество новостей
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArticleCell
        let article = news[indexPath.row]

        // Заполняем ячейку данными статьи
        cell.titleLabel.text = article.title ?? "Без заголовка"
        cell.announceLabel.text = article.announce ?? "Нет описания"

        // Загружаем изображение, если оно есть
        if let imageUrl = article.img?.url {
            cell.loadImage(from: imageUrl)
        } else {
            cell.articleImageView.image = nil
        }

        return cell
    }

    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = news[indexPath.row]
        presenter.didSelectArticle(article) // Уведомляем презентера о выборе статьи
    }

    // MARK: - Swipe Actions
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Поделиться") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            let article = self.news[indexPath.row]
            self.shareArticle(article) // Поделимся статьей
            completionHandler(true)
        }

        shareAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [shareAction]) // Возвращаем конфигурацию с кнопкой
    }

    private func shareArticle(_ article: ArticleModel) {
        guard let title = article.title, let url = article.img?.url else { return }
        let shareText = "Посмотрите эту новость: \(title)"
        let shareUrl = url.absoluteString

        // Создаем и показываем Activity View Controller для обмена
        let activityViewController = UIActivityViewController(activityItems: [shareText, shareUrl], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
