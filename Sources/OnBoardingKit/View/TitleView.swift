//
//  TitleView.swift
//  
//
//  Created by yeonBlue on 2023/02/09.
//

import UIKit

class TitleView: UIView {
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = themeFont
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let themeFont: UIFont
    
    // MARK: - Init
    init(themeFont: UIFont) {
        self.themeFont = themeFont
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 24, left: 36, bottom: 36, right: 24))
        }
    }
    
    func setTitle(text: String?) {
        titleLabel.text = text
    }
}
