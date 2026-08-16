//
//  ViewController.swift
//  Opus
//
//  Created by Ar2c on 2026/07/20.
//

import UIKit

class ViewController: UIViewController {
    private let tableView:UITableView = UITableView()
    var items = ["BlueSquare", "BlueSquareCA", "ClosureCallback"]
    let cellID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Opus"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        // 纯代码实现界面必加（？）
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // 必须放到constraint前面，不然系统不知道tableView的父级是谁
        view.addSubview(tableView)
        
        // 分别对齐上，下，左，右
        let top = self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leading = self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
        
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        // 加个箭头,提示这行能点进去
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let detailVC = BlueSquare()
            navigationController?.pushViewController(detailVC, animated: true)
        case 1:
            let detailVC = BlueSquareCA()
            navigationController?.pushViewController(detailVC, animated: true)
        case 2:
            let detailVC = ClosureCallback()
            detailVC.closure = { [weak self] in
                self?.items[1] = "已触发回调"
                self?.tableView.reloadData()
            }
            navigationController?.pushViewController(detailVC, animated: true)
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 把deselect效果放到‘滑动返回动画’刚刚开始播放的时候
        if let indexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: indexPath, animated: animated)
            }
    }
}
