//
//  CustomButton.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/31.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    private var action: (() -> Void)?

    init(title: String, titleColor: UIColor, action: @escaping () -> Void) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.action = action
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        action?()
    }

    private func setupButton() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .systemBlue
    }
}
