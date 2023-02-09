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
            views.append(AnimatedBarView(barColor: viewTintColor))
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
    private var currentIdx: Int = -1
    
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
        timer?.setEventHandler(handler: { [weak self] in
            DispatchQueue.main.async {
                self?.showNextImage()
            }
        })
    }
    
    private func showNextImage() {
        
        let nextImage: UIImage
        let nextTitle: String
        let nextBarView: AnimatedBarView
        
        // index가 마지막이면 맨 처음을 보여줘야 함, 아니면 다음 Idx
        if slides.indices.contains(currentIdx + 1) {
            nextImage = slides[currentIdx + 1].image
            nextTitle = slides[currentIdx + 1].title
            nextBarView = barView[currentIdx + 1]
            currentIdx += 1
        } else {
            nextImage = slides[0].image
            nextTitle = slides[0].title
            nextBarView = barView[0]
            currentIdx = 0
        }
        
        UIView.transition(with: imageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.imageView.image = nextImage },
                          completion: nil)
        titleView.setTitle(text: nextTitle)
        nextBarView.startAnimating()
    }
}
