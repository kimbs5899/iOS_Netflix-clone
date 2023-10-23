//
//  ViewController.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/18.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // 화면을 나갔을때
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("home disappear")
    }
    
    let headerView = HomeTableHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.frame = CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width, height: 400)
        tableView.tableHeaderView = headerView
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        // 클래스 이름 주의하기
        tableView.register(HomeTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "HomeTableViewHeaderView")
        tableView.backgroundColor = .black
        
        registObserver()
    }
    
    func registObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(presentDetailVC), name: NSNotification.Name("presentDetailVC"), object: nil)
    }
    
    @objc func presentDetailVC(notification: Notification) {
        if let hasResult = notification.object as? MovieResult {
            let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
            detailVC.movieResult = hasResult
            self.present(detailVC, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTableViewHeaderView") as! HomeTableViewHeaderView
        headerView.title = MediaType(rawValue: section)?.title
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return MediaType.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.requestMediaAPI(type: MediaType(rawValue: indexPath.section))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let area:CGFloat = 100
        let alpha = min(1, scrollView.contentOffset.y / area)
        
        if let homenavi =  self.navigationController as? HomeNaviViewController {
            homenavi.effectViewAlpha = alpha
        }
    }
}
