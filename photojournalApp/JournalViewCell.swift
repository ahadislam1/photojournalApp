//
//  JournalViewCell.swift
//  photojournalApp
//
//  Created by Ahad Islam on 4/30/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import SnapKit
import EMTNeumorphicView

class JournalViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var label: UILabel = {
        let l = UILabel()
        l.text = "text"
        l.numberOfLines = 2
        l.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return l
    }()
    
    private lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.text = "Date"
        l.font = UIFont.preferredFont(forTextStyle: .caption1)
        return l
    }()
    
    private lazy var neuView: EMTNeumorphicView = {
        let v = EMTNeumorphicView()
        v.neumorphicLayer?.backgroundColor = UIColor.systemGroupedBackground.cgColor
        v.neumorphicLayer?.cornerRadius = 24
        // set convex or concave.
        v.neumorphicLayer?.depthType = .convex
        // set elementDepth (corresponds to shadowRadius). Default is 5
        v.neumorphicLayer?.elementDepth = 7
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    private func setupSubviews() {
        setupNeuview()
    }
    
    private func setupNeuview() {
        contentView.addSubview(neuView)
        neuView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
}
