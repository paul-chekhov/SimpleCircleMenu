//
//  CircleMenuMainButton.swift
//  CircleMenu
//
//  Created by Pavel Chehov on 08/11/2018.
//

import UIKit
import Lottie
import PromiseKit

enum AnimationType {
    case open, close
}

public class CircleMenuMainButton: BasicCircleMenuButton {
    static let size = 52
    private let animationViewSize = 24
    private let startScale: CGFloat = 0.85
    private let endScale: CGFloat = 1.0
    private let scaleDuration = 0.1
    private let openAnimationKey = "hamburger-open"
    private let closeAnimationKey = "hamburger-close"
    private var mainButtonOpenAnimation: AnimationView
    private var mainButtonCloseAnimation: AnimationView
    private var keyPaths: [AnimationKeypath]
    private var colorValue: ColorValueProvider?
    public private(set) var isOpen: Bool = false

    public var unfocusedIconColor: UIColor? {
        didSet {
            colorValue = ColorValueProvider(unfocusedIconColor!.lottieColorValue)
            for key in keyPaths {
                mainButtonOpenAnimation.setValueProvider(colorValue!, keypath: key)
                mainButtonCloseAnimation.setValueProvider(colorValue!, keypath: key)
            }
        }
    }

    public convenience init() {
        self.init(frame: CGRect.zero)
    }

    public override init(frame: CGRect) {
        let mainButtonAnimationView = UIView()
        mainButtonAnimationView.frame = CGRect(x: (CircleMenuMainButton.size - animationViewSize) / 2, y: (CircleMenuMainButton.size - animationViewSize) / 2, width: animationViewSize, height: animationViewSize)
        mainButtonAnimationView.backgroundColor = UIColor.clear
        
        let openPath = JsonReader.path(for: openAnimationKey)
        mainButtonOpenAnimation = AnimationView(filePath: openPath ?? "")
        mainButtonOpenAnimation.isHidden = false
        mainButtonOpenAnimation.frame = mainButtonAnimationView.bounds

        let closePath = JsonReader.path(for: closeAnimationKey)
        mainButtonCloseAnimation = AnimationView(filePath: closePath ?? "")
        mainButtonCloseAnimation.isHidden = true
        mainButtonCloseAnimation.frame = mainButtonAnimationView.bounds

        mainButtonAnimationView.addSubview(mainButtonOpenAnimation)
        mainButtonAnimationView.addSubview(mainButtonCloseAnimation)

        keyPaths = [AnimationKeypath]()
        keyPaths.append(AnimationKeypath(keypath: "line1.Rectangle 1.Fill 1.Color"))
        keyPaths.append(AnimationKeypath(keypath: "line2.Rectangle 1.Fill 1.Color"))
        keyPaths.append(AnimationKeypath(keypath: "line3.Rectangle 1.Fill 1.Color"))

        super.init(frame: frame)
        mainButtonAnimationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mainButtonAnimationViewOnTap)))

        backgroundColor = UIColor.white
        addSubview(mainButtonAnimationView)
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func mainButtonAnimationViewOnTap() {
        sendActions(for: .touchUpInside)
    }

    @objc func touchUpInside() {
        animateScale()
        playAnimation(type: isOpen ? .close : .open)
    }

    func playAnimation(type: AnimationType) {
        switch type {
        case .open:
            mainButtonOpenAnimation.play { _ in
                self.mainButtonOpenAnimation.isHidden = true
                self.mainButtonCloseAnimation.isHidden = false
                self.mainButtonOpenAnimation.stop()
                self.isOpen = !self.isOpen
            }
        case .close:
            mainButtonCloseAnimation.play { _ in
                self.mainButtonCloseAnimation.isHidden = true
                self.mainButtonOpenAnimation.isHidden = false
                self.mainButtonCloseAnimation.stop()
                self.isOpen = !self.isOpen
            }
        }

    }

    private func animateScale() {
        UIView.animate(withDuration: scaleDuration, animations: {
            self.transform = CGAffineTransform.init(scaleX: self.startScale, y: self.startScale)
        }, completion: { _ in
            UIView.animate(withDuration: self.scaleDuration, animations: {
                self.transform = CGAffineTransform.init(scaleX: self.endScale, y: self.endScale)
            })
        })
    }
}
