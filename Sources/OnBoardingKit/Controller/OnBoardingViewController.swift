//
//  OnBoardingViewController.swift
//  
//
//  Created by yeonBlue on 2023/02/09.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {
    
    // MARK: - Properties
    private let slides: [Slide]
    private let tintColor: UIColor
    
    private lazy var transitionView: TransitionView = {
        let v = TransitionView(slides: slides, tintColor: tintColor)
        return v
    }()
    
    private lazy var buttonContainerView: ButtonContainerView = {
        let v = ButtonContainerView(tintColor: tintColor)
        v.nextButtonDidTap = {
            print("nextButtonDidTap")
        }
        
        v.getStartedButtonDidTap = {
            print("getStartedButtonDidTap")
        }
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [transitionView, buttonContainerView])
        v.axis = .vertical
        return v
    }()
    
    // MARK: - Init
    public init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionView.start()
    }
    
    // MARK: - Setup
    private func setupViews() {
        view.backgroundColor = .red
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        buttonContainerView.snp.makeConstraints {
            $0.height.equalTo(120)
        }
    }
}
