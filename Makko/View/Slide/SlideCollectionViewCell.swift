//
//  SlideCollectionViewCell.swift
//  Makko
//
//  Created by Макей 😈 on 03.01.2024.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var slideImage: UIImageView!
    
    
    @IBOutlet weak var regButton: UIButton!
    
    @IBOutlet weak var authButton: UIButton!
    
    static var reuseId = "SlideCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(slide: Slides) {
        slideImage.image = slide.img
        descriptionText.text = slide.text
        
        if slide.id == 3 {
            regButton.isHidden = false
            
            authButton.isHidden = false
        }
    }
    
 
    @IBAction func regButtonClick(_ sender: Any) {
    }
    

    @IBAction func authButtonClick(_ sender: Any) {
    }
}
