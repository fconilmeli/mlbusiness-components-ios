//
//  MLBusinessPillView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 20/07/2020.
//

import Foundation
import MLUI

public class MLBusinessPillView: UIView {
    public override var tintColor: UIColor! {
        didSet {
            textLabel.textColor = tintColor
            iconImageView.tintColor = tintColor
        }
    }

    public var text: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
            toggleSizeChange()
        }
    }

    public var icon: UIImage? {
        get {
            return iconImageView.image
        }
        set {
            iconImageView.image = newValue?.withRenderingMode(.alwaysTemplate)
            toggleSizeChange()
        }
    }

    public var fontSize: CGFloat {
        get {
            return textLabel.font.pointSize
        }
        set {
            textLabel.font = textLabel.font.withSize(newValue)
            toggleSizeChange()
        }
    }

    private let textLabel: UILabel = {
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .right
        textLabel.font = MLStyleSheetManager.styleSheet.boldSystemFont(ofSize: CGFloat(9.0))
        textLabel.numberOfLines = 1
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.70
        return textLabel
    }()

    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView(frame: .zero)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image?.withRenderingMode(.alwaysTemplate)
        return iconImageView
    }()

    private var imageWidth, imageLeft: NSLayoutConstraint?
    private var pillHeight: CGFloat

    init(with pillHeight: CGFloat = 10) {
        self.pillHeight = pillHeight
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(iconImageView)
        addSubview(textLabel)
    }

    private func setupConstraints() {
        let width = iconImageView.widthAnchor.constraint(equalToConstant: 0)
        let left = iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5)

        imageWidth = width
        imageLeft = left

        NSLayoutConstraint.activate([
            left,
            iconImageView.heightAnchor.constraint(equalTo: textLabel.heightAnchor, multiplier: 0.8),
            width,
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            textLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 3),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor),
            textLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 0),
            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: pillHeight),
        ])

        textLabel.setContentHuggingPriority(.required, for: .vertical)
        textLabel.setContentHuggingPriority(.required, for: .horizontal)
    }

    private func toggleSizeChange() {
        if iconImageView.image == nil {
            imageWidth?.constant = 0
            imageLeft?.constant = 5
        } else {
            imageWidth?.constant = 8
            imageLeft?.constant = 8
        }
    }
}
