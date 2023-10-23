//
//  HomeTableViewHeaderView.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/23.
//

import UIKit

class HomeTableViewHeaderView: UITableViewHeaderFooterView {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = true
        titleLabel.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        titleLabel.frame = CGRect(x: -20, y: -5, width: 200, height: 20) // 원하는 위치와 크기로 설정
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.contentView.backgroundColor = .clear
//        titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.contentView.leftAnchor, multiplier: 5).isActive = true
//        titleLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: self.contentView.bottomAnchor, multiplier: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var titleLabel: UILabel  = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()

}
