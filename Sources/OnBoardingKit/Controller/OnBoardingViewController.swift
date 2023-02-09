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
    private let themeFont: UIFont
    
    private lazy var transitionView: TransitionView = {
        let v = TransitionView(slides: slides, tintColor: tintColor, themeFont: themeFont)
        return v
    }()
    
    private lazy var buttonContainerView: ButtonContainerView = {
        let v = ButtonContainerView(tintColor: tintColor)
        v.nextButtonDidTap = { [weak self] in
            guard let self = self else { return }
            self.nextButtonDidTap?(self.transitionView.slideIdx)
            self.transitionView.handleTap(direction: .right)
        }
        
        v.getStartedButtonDidTap = { [weak self] in
            self?.getStartedButtonDidTap?()
        }
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [transitionView, buttonContainerView])
        v.axis = .vertical
        return v
    }()
    
    var nextButtonDidTap: ((Int) -> Void)?
    var getStartedButtonDidTap: (() -> Void)?
    
    // MARK: - Init
    public init(slides: [Slide], tintColor: UIColor, themeFont: UIFont) {
        self.slides = slides
        self.tintColor = tintColor
        self.themeFont = themeFont
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGesture()
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
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
        transitionView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewDidTapped(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: view)
        let midPoint = view.frame.size.width / 2
        
        if point.x < midPoint {
            transitionView.handleTap(direction: .left)
        } else {
            transitionView.handleTap(direction: .right)
        }
    }
    
    // MARK: - Functions
    func stopAnimation() {
        transitionView.stop()
    }
}
