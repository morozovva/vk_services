//
//  ImageView.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import UIKit

final class ImageView: UIImageView {
    
    var currentDataTask: URLSessionDataTask?
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    func loadImage(by url: URL) {
        image = nil
        
        currentDataTask?.cancel()
        
        currentDataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                
                self.hideLoadingView()
                
                if let error = error {
                    print("Ошибка загрузки картинки: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Ошибка загрузки картинки: неверный ответ http")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Ошибка загрузки картинки: ошибка данных")
                    return
                }
            
                DispatchQueue.main.async {
                    self.image = image
                }
        }
                
        showLoadingView()
        currentDataTask?.resume()
    }
            
    
    private func showLoadingView() {
        addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        activityIndicatorView.startAnimating()

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    private func hideLoadingView() {
        DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.removeFromSuperview()
            }
    }
    
}
