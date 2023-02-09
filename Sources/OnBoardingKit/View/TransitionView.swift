//
//  TransitionView.swift
//  
//
//  Created by yeonBlue on 2023/02/09.
//

import UIKit


class TransitionView: UIView {
    
    // MARK: - Properties
    
    private var timer: DispatchSourceTimer?
    
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var barView: [AnimatedBarView] = {
        var views: [AnimatedBarView] = []
        slides.forEach { _ in
            views.append(AnimatedBarView())
        }
        
        return views
    }()
    
    private lazy var barStackView: UIStackView = {
        let v = UIStackView()
        barView.forEach { barView in
            v.addArrangedSubview(barView)
        }
        v.axis = .horizontal
        v.spacing = 8
        v.distribution = .fillEqually
        return v
    }()
    
    private lazy var titleView: TitleView = {
        let v = TitleView()
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [imageView, titleView])
        v.axis = .vertical
        v.distribution = .fill
        return v
    }()
    
    
    private let slides: [Slide]
    private let viewTintColor: UIColor
    
    // MARK: - Init
    init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
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
        addSubview(barStackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        barStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(snp.topMargin)
            $0.height.equalTo(4)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(stackView.snp.height).multipliedBy(0.8)
        }
    }
    
    // MARK: - Functions
    public func start() {
        buildTimerIfNeeded()
        timer?.resume()
    }
    
    public func stop() {
        timer?.cancel()
        timer = nil
    }
    
    private func buildTimerIfNeeded() {
        guard timer == nil else { return }
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now(), repeating: .seconds(3), leeway: .seconds(1)) // leeway는 일종의 threshold
        timer?.setEventHandler(handler: {
            print("show next img")
        })
    }
}
