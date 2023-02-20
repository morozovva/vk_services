//
//  ItemListViewController.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import UIKit

final class ItemListViewController: UIViewController {
    
    private let itemListView = ItemListView()
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTitle()
        performAsyncTasks()
    }
}

private extension ItemListViewController {
    
    private func setupTitle() {
        title = "Проекты VK"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupView() {
        view.addSubview(itemListView)
        itemListView.frame = view.bounds
        itemListView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        itemListView.didSelectItem = { [weak self] item in
            let vc = ItemPageViewController()
            vc.configure(item: item)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func performAsyncTasks() {
        Task {
            await getItems()
            itemListView.items = items
        }
    }
    
        @objc func getItems() async {
            do {
                let result = try await NetworkManager().getData(
                    by: NetworkURLs.items,
                    type: ItemResponse.self)
                items = result.items
            } catch {
                showAlert(with: error.localizedDescription)
                showErrorScreen()
            }
        }
    
        func showAlert(with title: String) {
            let ac = UIAlertController(
                title: title,
                message: nil,
                preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Понятно...", style: .default))
            present(ac, animated: true)
        }
    
        func showErrorScreen() {
            let label : UILabel = {
                let label = UILabel()
                label.text = "Попробуйте перезагрузить приложение или повторите попытку позднее"
                label.numberOfLines = 0
                label.textColor = .gray
                label.font = .systemFont(ofSize: 20)
                label.textAlignment = .center
                return label
            }()
            view.addSubview(label)
    
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
            ])
        }
}
