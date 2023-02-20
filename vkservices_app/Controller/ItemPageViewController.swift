//
//  ItemPageViewController.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import UIKit

final class ItemPageViewController: UIViewController {

    let itemPageView = ItemPageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(itemPageView)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        itemPageView.frame = view.bounds
    }

    func configure(item: Item) {
        title = item.name
        itemPageView.configure(item: item)
    }
}
