//
//  ArticleModel.swift (Model)
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 17.12.2024.
//

import Foundation

// MARK: - Constants
private struct Constants {
    static let baseUrl = "https://news.myseldon.com/ru/news/index"
    static let defaultNewsId = 0
}

// MARK: - ArticleModel
struct ArticleModel: Decodable {
    var newsId: Int?
    var title: String?
    var announce: String?
    var img: ImageContainer?
    var requestId: String?
    
    var articleUrl: URL? {
        let requestId = requestId ?? ""
        let newsId = newsId ?? Constants.defaultNewsId
        return URL(string: "\(Constants.baseUrl)/\(newsId)?requestId=\(requestId)")
    }
}

// MARK: - ImageContainer
struct ImageContainer: Decodable {
    var url: URL?
}
