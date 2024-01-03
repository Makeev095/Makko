//
//  LoginViewController.swift
//  Makko
//
//  Created by Макей 😈 on 03.01.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var slides: [Slides] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        
        let slide1 = Slides(id: 1, text: "Текст для первого слайда", img: UIImage(imageLiteralResourceName: "slide1"))
        let slide2 = Slides(id: 2, text: "Текст для второго слайда", img: UIImage(imageLiteralResourceName: "slide2"))
        let slide3 = Slides(id: 3, text: "Текст для третьего слайда", img: UIImage(imageLiteralResourceName: "slide3"))
        
        slides.append(slide1)
        slides.append(slide2)
        slides.append(slide3)
    }
    
    func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        collectionView.isPagingEnabled = true
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: SlideCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: SlideCollectionViewCell.reuseId)
    }
}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.reuseId, for: indexPath) as! SlideCollectionViewCell
        
        let slide = slides[indexPath.row]
        
        cell.configure(slide: slide)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.view.frame.size
    }
}
