//
//  NewsRouter.swift (Router)
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 18.12.2024.
//

import UIKit

// MARK: - News Router Protocol
protocol NewsRouter {
    func navigateToArticleDetail(_ article: ArticleModel)
}

// MARK: - News Router Implementation
class NewsRouterImpl: NewsRouter {
    // MARK: - Properties
    weak var viewController: UIViewController?

    // MARK: - Initializer
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // MARK: - Methods
    func navigateToArticleDetail(_ article: ArticleModel) {
        let webVC = WebViewController()
        webVC.url = article.articleUrl
        viewController?.navigationController?.pushViewController(webVC, animated: true)
    }
}
