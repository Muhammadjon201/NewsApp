//
//  Article.swift
//  NewsApp
//
//  Created by ericzero on 7/2/23.
//

import Foundation
import UIKit

struct ArticleResponse: Decodable {
    let articles: [Article]
}


struct Article: Decodable {
    let title: String
    let description: String?
    let urlToImage: String?
}
