//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by ericzero on 7/2/23.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

struct ArticleListViewModel {
    let articleVM: [ArticleViewModel]
}

extension ArticleListViewModel {
    init(_ articles: [Article]) {
        self.articleVM = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleListViewModel {
    func articleAt(_ index: Int) -> ArticleViewModel {
        return self.articleVM[index]
    }
}

struct ArticleViewModel {
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
    
    var urlToImage: Observable<String> {
        return Observable<String>.just(article.urlToImage ?? "")
    }
}
