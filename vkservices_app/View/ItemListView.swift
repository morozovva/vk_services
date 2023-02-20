//
//  ItemListView.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import UIKit

import UIKit

final class ItemListView: UIView {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            ItemTableViewCell.self,
            forCellReuseIdentifier: ItemTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    var items = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var didSelectItem: ((Item) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(tableView)
        tableView.frame = bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
}

extension ItemListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemTableViewCell.identifier,
            for: indexPath)
                as? ItemTableViewCell else {
                return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        
        cell.configure(
            with: item.name,
            imageURL: item.icon_url)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}

extension ItemListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selected = items[indexPath.row]
        didSelectItem?(selected)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
}
