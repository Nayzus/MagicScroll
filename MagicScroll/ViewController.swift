//
//  ViewController.swift
//  RectangleGradient
//
//  Created by Pavel Parshutkin on 02.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = configureScrollView()
    private lazy var imageView: UIImageView = configureImageView()
    
    let defaultHeight: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
       
        self.setupConstraints()
    }

    private func configureScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.addSubview(imageView)
        view.delegate = self
        view.alwaysBounceVertical = true
        view.contentSize = .init(width: view.frame.width, height: 2000)
        
        view.contentInsetAdjustmentBehavior = .always
        view.automaticallyAdjustsScrollIndicatorInsets = false
    
     
        return view
    }
    
    private func configureImageView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "macos")
        view.contentMode = .scaleAspectFill
        
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: defaultHeight)
        view.layer.masksToBounds = true
        
        return view
        
    }

    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let calcualateHeight = defaultHeight - scrollView.contentOffset.y
        let idealHeight = (calcualateHeight >= defaultHeight ? calcualateHeight : defaultHeight)
        
        let offset = scrollView.contentOffset.y >= 0  ? 0 : scrollView.contentOffset.y
        
        imageView.frame = .init(x: 0, y: offset, width: view.frame.width, height: idealHeight)
        scrollView.scrollIndicatorInsets = .init(top: idealHeight , left: 0, bottom: 0, right: 0)

    }
}
