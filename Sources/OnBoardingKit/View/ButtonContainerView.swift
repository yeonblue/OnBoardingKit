//
//  ButtonContainerView.swift
//  
//
//  Created by yeonBlue on 2023/02/09.
//

import UIKit
import SnapKit

class ButtonContainerView: UIView {
    
    // MARK: - Properties
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.borderColor = viewTintColor.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(viewTintColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        button.backgroundColor = viewTintColor
        button.layer.cornerRadius = 12
        button.layer.shadowColor = viewTintColor.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.layer.shadowRadius = 8
        button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [nextButton, getStartedButton])
        v.axis = .horizontal
        v.spacing = 24
        return v
    }()
    
    private let viewTintColor: UIColor
    
    var nextButtonDidTap: (() -> Void)? // delegate로 넘길 수도 있지만, 여기서는 closure로 넘김
    var getStartedButtonDidTap: (() -> Void)?
    
    // MARK: - Init
    init(tintColor: UIColor) {
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = .systemBackground
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 24, left: 24, bottom: 36, right: 24))
        }
        
        nextButton.snp.makeConstraints {
            $0.width.equalTo(getStartedButton.snp.width).multipliedBy(0.5)
        }
    }
    
    // MARK: - Functions
    @objc private func nextButtonTapped() {
        nextButtonDidTap?()
    }
    
    @objc private func getStartedButtonTapped() {
        getStartedButtonDidTap?()
    }
}
