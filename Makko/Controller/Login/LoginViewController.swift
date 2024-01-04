//
//  LoginViewController.swift
//  Makko
//
//  Created by Макей 😈 on 03.01.2024.
//

import UIKit


protocol LoginViewControllerDelegate {
    func openRegistrationVC()
    func openAuthorizationVC()
    func closeVC()
}

class LoginViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var slidesSlider = SliderSlides()
    var slides: [Slides] = []
    
    var authorizationVC: AuthorizationViewController!
    var registrationVC: RegistrationViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        slides = slidesSlider.getSlides()
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
        
        cell.delegate = self
        
        let slide = slides[indexPath.row]
        
        cell.configure(slide: slide)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.view.frame.size
    }
}

extension LoginViewController: LoginViewControllerDelegate {
    
    func openAuthorizationVC() {
        
        if authorizationVC == nil {
            authorizationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthorizationViewController") as! AuthorizationViewController?
        }
        
        authorizationVC.delegate = self
        self.view.insertSubview(authorizationVC.view, at: 1)
    }
    
    func openRegistrationVC() {
        
        if registrationVC == nil {
            registrationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController?
        }
        
        registrationVC.delegate = self
        self.view.insertSubview(registrationVC.view, at: 1)
    }
    
    func closeVC() {
        if authorizationVC != nil {
            authorizationVC.view.removeFromSuperview()
            authorizationVC = nil
        }
        
        if registrationVC != nil {
            registrationVC.view.removeFromSuperview()
            registrationVC = nil
        }
    }
}
