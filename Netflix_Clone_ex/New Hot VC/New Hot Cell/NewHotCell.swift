//
//  NewHotCell.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/24.
//

import UIKit
import AVKit

protocol PlayOrStopType {
    func moviePlay()
    func movieStop()
}


class NewHotCell: UITableViewCell, PlayOrStopType {
    
    var baseContainerView: UIView = {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .black
        return baseView
    }()
    
    var movieContainerView: UIView = {
        let movieView = UIView()
        movieView.translatesAutoresizingMaskIntoConstraints = false
        movieView.backgroundColor = .black
        return movieView
    }()
    
    var thumbnail: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(systemName: "photo")
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var coverImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(systemName: "photo")
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()
    
    var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()
    
    var dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()
    
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    var movieResult: MovieResult? {
        didSet{
            settingPlayerURL()
            settingDate()
            settingTitle()
            settingDescription()
            requestThumbnaulIamge()
            requestCoverImage()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .black
        // 뷰를 올리고 나서 constraints설정을 해야함.
        self.contentView.addSubview(baseContainerView)
        baseContainerView.addSubview(movieContainerView)
        baseContainerView.addSubview(thumbnail)
        baseContainerView.addSubview(dateLabel)
        baseContainerView.addSubview(titleLabel)
        baseContainerView.addSubview(descriptionLabel)
        
        // 기본 셀 컨텐츠뷰 베이스가 되는 뷰를 올림.
        addBaseView()
        
        // 무비 컨테이너뷰
        addMovieContainerView()
        
        // 무비 레이어
        addMovieLayer()
        
        // 썸네일
        addThumbnail()
        
        // 날짜
        addDate()
        
        // 제목
        addTitle()
        
        // 내용
        addDescription()
        
        // 커버이미지
        addCoverImageWithSetAnchor()
        
        
    }
    
    private func requestCoverImage() {
        if let hasURLString = movieResult?.artworkUrl {
            NetworkLayer.request(urlString: hasURLString) { image in
                DispatchQueue.main.async {
                    self.coverImageView.image = image
                }
            }
        }
    }
    
    private func requestThumbnaulIamge() {
        if let hasURLString = movieResult?.artworkUrl {
            NetworkLayer.request(urlString: hasURLString) { image in
                DispatchQueue.main.async {
                    self.thumbnail.image = image
                }
            }
        }
    }
    
    private func settingDescription() {
        self.descriptionLabel.text = movieResult?.shortDescription
    }
    
    private func settingTitle() {
        self.titleLabel.text = movieResult?.trackName
    }
    
    private func settingDate() {
        if let hasDate = movieResult?.releaseDate {
            self.dateLabel.text = CommonUti.iso8601(date: hasDate, format: "yyyy-MM-dd")
//            let formatter = ISO8601DateFormatter()
//            if let isoDate = formatter.date(from: hasDate) {
//                let myFormatter = DateFormatter()
//                myFormatter.dateFormat = "yyyy-MM-dd"
//                let dateString = myFormatter.string(from: isoDate)
//                self.dateLabel.text = dateString
//            }
        }
    }
    
    private func settingPlayerURL() {
        if let previewURL = movieResult?.previewUrl, let hasURL = URL(string: previewURL) {
            self.player = AVPlayer(url: hasURL)
            self.playerLayer.player = self.player
            self.player.volume = 0
//            self.player.play()
        }
    }
    
    private func addDescription() {
        
        descriptionLabel.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: baseContainerView.rightAnchor, constant: -20).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: baseContainerView.bottomAnchor, constant: -30).isActive = true
    }
    private func addTitle() {
        
        titleLabel.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: baseContainerView.rightAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10).isActive = true
        
    }
    
    private func addDate() {
        dateLabel.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10).isActive = true
    }
    
    private func addThumbnail() {
        thumbnail.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        thumbnail.heightAnchor.constraint(equalToConstant: 70).isActive = true
        thumbnail.widthAnchor.constraint(equalToConstant: 50).isActive = true
        thumbnail.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -10).isActive = true
    }
    
    private func addMovieLayer() {
        movieContainerView.layer.addSublayer(playerLayer)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 200)
    }
    
    private func addCoverImageWithSetAnchor() {
        movieContainerView.addSubview(coverImageView)
        coverImageView.leftAnchor.constraint(equalTo: movieContainerView.leftAnchor).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: movieContainerView.rightAnchor).isActive = true
        coverImageView.topAnchor.constraint(equalTo: movieContainerView.topAnchor).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: movieContainerView.bottomAnchor).isActive = true
        
    }
    
    private func addMovieContainerView() {
        
        movieContainerView.topAnchor.constraint(equalTo: baseContainerView.topAnchor).isActive = true
        movieContainerView.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        movieContainerView.rightAnchor.constraint(equalTo: baseContainerView.rightAnchor).isActive = true
        movieContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        movieContainerView.bottomAnchor.constraint(equalTo: thumbnail.topAnchor,constant: -10).isActive = true
        
    }
    
    private func addBaseView() {

        baseContainerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 50).isActive = true
        baseContainerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        baseContainerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        baseContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    }
    
    func moviePlay() {
        if self.player.timeControlStatus != .playing {
            self.player.play()
            coverImageView.isHidden = true
        }
    }
    
    func movieStop() {
        self.player.pause()
        if self.player.currentTime().seconds > 1 {
            coverImageView.isHidden = true
        }else {
            coverImageView.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
