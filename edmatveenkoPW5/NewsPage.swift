//
//  NewsPage.swift (Model)
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 18.12.2024.
//

import Foundation

// MARK: - Constants
private struct Constants {
    static let defaultNewsCount = 0
}

// MARK: - NewsPage
struct NewsPage: Decodable {
    var news: [ArticleModel]?
    var requestId: String?
    
    mutating func passTheRequestId() {
        for i in 0..<getNewsCount() {
            news?[i].requestId = requestId
        }
    }
    
    private func getNewsCount() -> Int {
        return news?.count ?? Constants.defaultNewsCount
    }
}
