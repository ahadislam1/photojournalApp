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
import Combine

class JournalViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
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
    
    private lazy var button: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        b.setImage(UIImage(systemName: "ellipses.circle.fill"), for: .highlighted)
        b.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        b.tintColor = .systemBlue
        return b
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
    
    public var cellPublisher: AnyPublisher<JournalViewCell, Never> {
        return cellSubject.eraseToAnyPublisher()
    }
    
    private let cellSubject = PassthroughSubject<JournalViewCell, Never>()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
    }
    
    public func configureCell(page: Page) {
        imageView.image = UIImage(data: page.imageData)
        label.text = page.text
        dateLabel.text = "\(page.date)"
    }
    
    @objc
    private func buttonPressed() {
        
        cellSubject.send(self)
    }
    
    private func setupSubviews() {
        setupNeuview()
        setupImage()
        setupLabel()
        setupDateLabel()
        setupButton()
    }
    
    private func setupNeuview() {
        contentView.addSubview(neuView)
        neuView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
    
    private func setupImage() {
        neuView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(neuView.snp.height).dividedBy(1.76)
        }
    }
    
    private func setupLabel() {
        neuView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupDateLabel() {
        neuView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(label)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func setupButton() {
        neuView.addSubview(button)
        button.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
}
