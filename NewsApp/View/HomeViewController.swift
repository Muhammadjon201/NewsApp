//
//  HomeViewController.swift
//  NewsApp
//
//  Created by ericzero on 7/2/23.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class HomeViewController: UIViewController {
    
    lazy var tableV: UITableView = {
        let tableV = UITableView()
        tableV.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        return tableV
    }()
    
    let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "NEWS"
        self.view.backgroundColor = .white
        populateNews()
        constraints()
    }
    
    private func constraints(){
        
        tableV.delegate = self
        tableV.dataSource = self
        view.addSubview(tableV)
        
        tableV.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func populateNews(){
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=78366a4a843f45cb90c54418e90e46e2")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { articleResponse in
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                
                DispatchQueue.main.async {
                    self.tableV.reloadData()
                }
            }).disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM == nil ? 0: self.articleListVM.articleVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell()
            }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleContext.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionContext.rx.text)
            .disposed(by: disposeBag)
        
//        articleVM.urlToImage.asDriver(onErrorJustReturn: "")
//            .drive(cell.imageV.rx.image)
//            .disposed(by: disposeBag)
        
        articleVM.urlToImage.asDriver(onErrorJustReturn: "")
            .drive(onNext: { urlString in
                if let url = URL(string: urlString) {
                    cell.imageV.sd_setImage(with: url, completed: nil)
                } else {
                    cell.imageV.image = nil
                }
            })
            .disposed(by: disposeBag)

        
        return cell
    }
}
