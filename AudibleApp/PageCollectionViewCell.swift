//
//  PageCollectionViewCell.swift
//  AudibleApp
//
//  Created by CnC on 23/12/2017.
//  Copyright © 2017 cnc. All rights reserved.
//

import UIKit

class PageCollectionViewCell : UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }
            imageView.image = UIImage(named: page.imageName)
            
            let attributesTitle = [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold),
                NSAttributedStringKey.foregroundColor : UIColor.darkGray
            ]
            
            let attributesMessage = [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium),
                NSAttributedStringKey.foregroundColor : UIColor.gray
            ]
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: attributesTitle)
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: attributesMessage))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.length
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, length))
            
            textView.attributedText = attributedText
        }
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Components
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "image1.jpg")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    //MARK: Private Methods
    private func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        
        // Layout
        //Pin the leading edge of the collection view to the leading edge of superview
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        //Pin the top edge of the collection view to the top edge of superview
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        //Pin the leading edge of the collection view to the leading edge of superview
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        //Pin the leading edge of the collection view to the leading edge of superview
        imageView.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        
        
        lineSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lineSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lineSeparatorView.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
}
