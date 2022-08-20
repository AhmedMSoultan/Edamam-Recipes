//
//  NetworkLayer.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//


import UIKit
import Kingfisher

extension UIImageView
{
    func setImageByKingFisher (url: String , imageView: UIImageView){
        let url = URL(string: url)
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
