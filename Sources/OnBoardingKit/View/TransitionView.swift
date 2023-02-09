//
//  TransitionView.swift
//  
//
//  Created by yeonBlue on 2023/02/09.
//

import UIKit


class TransitionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = .green
    }
}
