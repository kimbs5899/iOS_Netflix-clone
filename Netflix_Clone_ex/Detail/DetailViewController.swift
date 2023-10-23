//
//  DetailViewController.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/27.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {
    
    private var loadedViewAndDataSet: (() -> Void)?
    
    var movieResult: MovieResult? {
        didSet{
              // 메모리에서 사라지지않는 문제가 발생함.
            loadedViewAndDataSet = { [weak self] in
                guard let self = self else { return }
                self.movieDescription.text = self.movieResult?.longDescription
                self.movieTitle.text = self.movieResult?.trackName
                if let previewUrl = self.movieResult?.previewUrl, let url = URL(string: previewUrl) {
                    self.playMovie(url: url)
                }
            }
        }
    }
    
    @IBOutlet private weak var movieContainerView: UIView!
    
    @IBOutlet private weak var movieTitle: UILabel!
    
    @IBOutlet private weak var movieDescription: UILabel!
    
    @IBAction private func play(_ sender: Any) {
        if player.timeControlStatus != .playing {
            player.play()
        }
    }
    
    @IBAction private func stop(_ sender: Any) {
        player.pause()
    }
    
    private func playMovie(url: URL) {
        player = AVPlayer(url: url)
        playerLayer.player = player
        
        player.play()
    }
    
    private var player = AVPlayer()
    private let playerLayer = AVPlayerLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadedViewAndDataSet?()
        // 메모리에서 사라지도록 호출되면 값을 nill로 지정
        loadedViewAndDataSet = nil
        // layer를 올린다. 라는 개념
        movieContainerView.layer.addSublayer(playerLayer)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
    }
    
    deinit {
        print("detailVC deinit")
    }
    
    
}
