//
//  NewHotViewController.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/18.
//

import UIKit

class NewHotViewController: UIViewController {

    @IBOutlet weak var newHotTableView: UITableView!
    
    var movieModel: MovieModel? {
        didSet{
            DispatchQueue.main.async {
                self.newHotTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 설정된 해당 title 모두가 변경된다.
//        self.title = "NEW & HOT"
        
        let lbl = UILabel()
        lbl.text = "NEW & HOT"
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .lightGray
        self.navigationItem.titleView = lbl
        
        newHotTableView.dataSource = self
        newHotTableView.delegate = self
        
        newHotTableView.rowHeight = UITableView.automaticDimension
        
        newHotTableView.register(NewHotCell.self, forCellReuseIdentifier: "NewHotCell")
        
        newHotTableView.register(DateHeaderView.self, forHeaderFooterViewReuseIdentifier: "DateHeaderView")
        
        newHotTableView.backgroundColor = .black
        
        NetworkLayer.request(type: .movie) { model in
            self.movieModel = model
        }
    }

}

extension NewHotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieModel?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewHotCell", for: indexPath) as! NewHotCell
        let movieResult = self.movieModel?.results[indexPath.section]
        cell.movieResult = movieResult
        return  cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
//        return CGFloat.leastNonzeroMagnitude // 가장 작은 양의 수
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateHeaderView") as! DateHeaderView
        
        if let dateString = movieModel?.results[section].releaseDate {
            
            let convertedDateString = CommonUti.iso8601(date: dateString, format: "M월\ndd")
                
                let attributedString = NSMutableAttributedString(string: convertedDateString)
                let monthRange = NSRange(location: 0, length: convertedDateString.count - 2)
                let dayRange = NSRange(location: convertedDateString.count - 2, length: 2)
                
                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: monthRange)
                attributedString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: monthRange)
                
                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: dayRange)
                attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: dayRange)
                
                headerView.dateAttributeString = attributedString
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieResult = movieModel?.results[indexPath.section]
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.movieResult = movieResult
        self.present(detailVC, animated: true)
//        detailVC.movieResult = movieResult
    }
    
}

extension NewHotViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("y:", scrollView.contentOffset.y)
        
        // visibleCell
        guard let visibleCells = newHotTableView.visibleCells as? [NewHotCell] else {
            return
        }
        playOrStop(positionY: 50, visibleCells: visibleCells)
//        guard let firstCell = visibleCells.first else {
//            return
//        }
//        if visibleCells.count == 1 {
//            firstCell.moviePlay()
//            return
//        }
//        let secondCell = visibleCells[1]
//
//        // position convert
//        let firstCellPositionY = newHotTableView.convert(firstCell.frame.origin, to: self.view).y
////        print("first : ", firstCellPositionY)
//
//        let secondCellPositionY = newHotTableView.convert(secondCell.frame.origin, to: self.view).y
////        print("second : ", secondCellPositionY)
//
//        if firstCellPositionY > 50 {
//            firstCell.moviePlay()
//
//            // 첫번째셀 뺸 나머지는 셀은 정지
//            var otherCells = visibleCells
//            otherCells.removeFirst()
//            otherCells.forEach { cell in
//                cell.movieStop()
//
//            }
//        }else {
//            secondCell.moviePlay()
//
//            // 두번째 셀 뺀 나머지 셀은 정지
//            var otherCells = visibleCells
//            otherCells.remove(at: 1)
//            otherCells.forEach { cell in
//                cell.movieStop()
//            }
//        }
    }
    
    func playOrStop<T>(positionY: CGFloat ,visibleCells: [T]) where T : UIView & PlayOrStopType {
        guard let firstCell = visibleCells.first else {
            return
        }
        if visibleCells.count == 1 {
            firstCell.moviePlay()
            return
        }
        let secondCell = visibleCells[1]
        
        let firstCellPositionY = newHotTableView.convert(firstCell.frame.origin, to: self.view).y
        
        if firstCellPositionY > positionY {
            firstCell.moviePlay()
            
            // 첫번째셀 뺸 나머지는 셀은 정지
            var otherCells = visibleCells
            otherCells.removeFirst()
            otherCells.forEach { cell in
                cell.movieStop()
                
            }
        }else {
            secondCell.moviePlay()
            
            // 두번째 셀 뺀 나머지 셀은 정지
            var otherCells = visibleCells
            otherCells.remove(at: 1)
            otherCells.forEach { cell in
                cell.movieStop()
            }
        }
    }
    
}

