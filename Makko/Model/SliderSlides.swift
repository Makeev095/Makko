//
//  SliderSlides.swift
//  Makko
//
//  Created by Макей 😈 on 04.01.2024.
//

import Foundation
import UIKit


class SliderSlides {
    
    func getSlides() -> [Slides] {
        var slides: [Slides] = []
        
        let slide1 = Slides(id: 1, text: "Текст для первого слайда", img: UIImage(imageLiteralResourceName: "slide1"))
        let slide2 = Slides(id: 2, text: "Текст для второго слайда", img: UIImage(imageLiteralResourceName: "slide2"))
        let slide3 = Slides(id: 3, text: "Текст для третьего слайда", img: UIImage(imageLiteralResourceName: "slide3"))
        
        slides.append(slide1)
        slides.append(slide2)
        slides.append(slide3)
        
        return slides
    }
}
