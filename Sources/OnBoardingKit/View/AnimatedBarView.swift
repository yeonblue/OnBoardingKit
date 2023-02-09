//
//  AnimatedBarView.swift
//  
//
//  Created by yeonBlue on 2023/02/09.
//

import UIKit
import SnapKit
import Combine

class AnimatedBarView: UIView {
    
    enum State {
        case clear
        case animating
        case filled
    }
    
    private lazy var backgroundBarView: UIView = {
        let v = UIView()
        v.backgroundColor = barColor.withAlphaComponent(0.2)
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var foregroundBarView: UIView = {
        let v = UIView()
        v.backgroundColor = barColor
        v.clipsToBounds = true
        v.alpha = 0.0
        return v
    }()
    
    @Published private var state: State = .clear
    private var cancellable = Set<AnyCancellable>()
    private var animator: UIViewPropertyAnimator!
    
    private let barColor: UIColor
    
    
    // MARK: - Init
    init(barColor: UIColor) {
        self.barColor = barColor
        super.init(frame: .zero)
        setLayout()
        setAnimator()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAnimator() {
        animator = UIViewPropertyAnimator(duration: 3.0,
                                          curve: .easeInOut,
                                          animations: {
            self.foregroundBarView.transform = .identity
        })
    }
    
    private func setLayout() {
        addSubview(backgroundBarView)
        backgroundBarView.addSubview(foregroundBarView)
        
        backgroundBarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        foregroundBarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func observe() {
        $state.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
                case .clear:
                    self.setAnimator()
                    self.foregroundBarView.alpha = 0.0
                    self.animator.stopAnimation(false)
                case .animating:
                    //self.foregroundBarView.transform = .init(scaleX: 0, y: 1.0)
                    self.foregroundBarView.transform = .init(translationX: -self.frame.size.width, y: 0)
                    self.foregroundBarView.alpha = 1.0
                    self.animator.startAnimation()
                case .filled:
                    self.animator.stopAnimation(true)
                    self.foregroundBarView.transform = .identity
            }
        }
        .store(in: &cancellable)
    }
    
    func startAnimating() {
        state = .animating
    }
    
    func reset() {
        state = .clear
    }
    
    func complete() {
        state = .filled
    }
}
