//
//  HomeTableViewCell.swift
//  NewsApp
//
//  Created by ericzero on 7/2/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    lazy var titleContext: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        return title
    }()

    lazy var descriptionContext: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        return title
    }()
    
    lazy var imageV: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    private func constraints(){
        addSubview(titleContext)
        addSubview(imageV)

        addSubview(descriptionContext)
        
        titleContext.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        imageV.snp.makeConstraints { make in
            make.top.equalTo(titleContext.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(250)
        }
        
        descriptionContext.snp.makeConstraints { make in
            make.top.equalTo(imageV.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
