//
//  HomeTableHeaderView.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/20.
//

import UIKit

class HomeTableHeaderView: UIView {
    
    init() {
        super.init(frame: .zero)
        addImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var imageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "81F5PF9oHhL._AC_UF1000,1000_QL80_"))
        
        // 자동 크기 지정
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    private func addImageView() {
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    

}
