//
//  ShimmerView.swift
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 18.12.2024.
//

import UIKit

class ShimmerView: UIView {
    
    // MARK: - Properties
    var gradientColorOne: CGColor = UIColor(white: Constants.gradientColorOneWhite, alpha: 1.0).cgColor
    var gradientColorTwo: CGColor = UIColor(white: Constants.gradientColorTwoWhite, alpha: 1.0).cgColor

    private var gradientLayer: CAGradientLayer?

    // MARK: - Constants
    private struct Constants {
        static let gradientColorOneWhite: CGFloat = 0.75
        static let gradientColorTwoWhite: CGFloat = 0.95
        static let animationFromValue: [CGFloat] = [-1.0, 0.0, 1.0]
        static let animationToValue: [CGFloat] = [0.0, 1.0, 2.0]
        static let animationDuration: TimeInterval = 1.5
        static let gradientStartPoint = CGPoint(x: 0.0, y: 1.0)
        static let gradientEndPoint = CGPoint(x: 1.0, y: 1.0)
        static let gradientLocations: [NSNumber] = [0.0, 0.5, 1.0]
    }

    // MARK: - Public Methods
    func startAnimating() {
        // Удаляем предыдущий слой, если он существует
        gradientLayer?.removeFromSuperlayer()

        // Создаем новый градиентный слой
        gradientLayer = CAGradientLayer()
        guard let gradientLayer = gradientLayer else { return }

        // Устанавливаем фрейм градиентного слоя
        gradientLayer.frame = self.bounds

        // Устанавливаем начальные и конечные точки
        gradientLayer.startPoint = Constants.gradientStartPoint
        gradientLayer.endPoint = Constants.gradientEndPoint

        // Устанавливаем цвета градиента
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = Constants.gradientLocations

        // Добавляем градиентный слой на вью
        self.layer.addSublayer(gradientLayer)

        // Запускаем анимацию
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = Constants.animationFromValue
        animation.toValue = Constants.animationToValue
        animation.duration = Constants.animationDuration
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmerEffect")
    }

    func stopAnimating() {
        gradientLayer?.removeFromSuperlayer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = self.bounds
    }
}
