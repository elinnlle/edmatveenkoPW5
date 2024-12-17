//
//  NewsPresenter.swift (Presenter)
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 18.12.2024.
//

import Foundation

// MARK: - News Presenter Protocol
protocol NewsPresenter {
    func fetchNews()
    func didSelectArticle(_ article: ArticleModel)
}

// MARK: - News Presenter Implementation
class NewsPresenterImpl: NewsPresenter {
    // MARK: - Properties
    weak var view: NewsView?
    var interactor: NewsInteractor
    var router: NewsRouter

    // MARK: - Initializer
    init(view: NewsView, interactor: NewsInteractor, router: NewsRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Methods
    func fetchNews() {
        interactor.fetchNews { [weak self] result in
            switch result {
            case .success(let news):
                self?.view?.displayNews(news)
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }

    func didSelectArticle(_ article: ArticleModel) {
        router.navigateToArticleDetail(article)
    }
}
