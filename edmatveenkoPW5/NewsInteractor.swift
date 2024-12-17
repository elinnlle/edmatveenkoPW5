//
//  NewsInteractor.swift (Interactor)
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 18.12.2024.
//

import Foundation

// MARK: - Constants
private struct Constants {
    static let baseUrl = "https://news.myseldon.com/api/Section"
    static let defaultRubricId = 4
    static let defaultPageIndex = 1
    static let pageSize = 8
    static let errorCode = 0
}

// MARK: - NewsInteractor Protocol
protocol NewsInteractor {
    func fetchNews(completion: @escaping (Result<[ArticleModel], Error>) -> Void)
}

// MARK: - NewsInteractorImpl
class NewsInteractorImpl: NewsInteractor {
    func fetchNews(completion: @escaping (Result<[ArticleModel], Error>) -> Void) {
        guard let url = getURL(rubric: Constants.defaultRubricId, pageIndex: Constants.defaultPageIndex) else {
            completion(.failure(NSError(domain: "Invalid URL", code: Constants.errorCode, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: Constants.errorCode, userInfo: nil)))
                return
            }
            do {
                var newsPage = try JSONDecoder().decode(NewsPage.self, from: data)
                newsPage.passTheRequestId()
                completion(.success(newsPage.news ?? []))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    private func getURL(rubric: Int, pageIndex: Int) -> URL? {
        return URL(string: "\(Constants.baseUrl)?rubricId=\(rubric)&pageSize=\(Constants.pageSize)&pageIndex=\(pageIndex)")
    }
}
