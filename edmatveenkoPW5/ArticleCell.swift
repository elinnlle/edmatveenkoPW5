//
//  ArticleCell.swift (View)
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 18.12.2024.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let announceLabel = UILabel()
    let shimmerView = ShimmerView()
    let articleImageView = UIImageView()
    
    // MARK: - Constants
    private struct Constants {
        static let titleFontSize: CGFloat = 20.0
        static let announceFontSize: CGFloat = 16.0
        static let imageViewSize: CGFloat = 90.0
        static let imageViewPadding: CGFloat = 8.0
        static let titlePadding: CGFloat = 12.0
        static let announcePadding: CGFloat = 4.0
        static let announceBottomPadding: CGFloat = 8.0
        static let shimmerAnimationDuration: TimeInterval = 0.3
    }

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        selectionStyle = .none

        // Настройка заголовка
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)

        // Настройка описания
        announceLabel.font = UIFont.systemFont(ofSize: Constants.announceFontSize)
        announceLabel.textColor = .lightGray
        announceLabel.numberOfLines = 2
        contentView.addSubview(announceLabel)

        // Настройка изображения статьи
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        articleImageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        contentView.addSubview(articleImageView)

        // Настройка мерцающего вида
        shimmerView.backgroundColor = .clear
        contentView.addSubview(shimmerView)

        // Установка ограничений с использованием UIView+Pin
        articleImageView.pinTop(to: contentView, Constants.imageViewPadding)
        articleImageView.pinLeft(to: contentView, Constants.imageViewPadding)
        articleImageView.setWidth(Constants.imageViewSize)
        articleImageView.setHeight(Constants.imageViewSize)

        titleLabel.pinTop(to: contentView, Constants.imageViewPadding)
        titleLabel.pinLeft(to: articleImageView.trailingAnchor, Constants.titlePadding)
        titleLabel.pinRight(to: contentView, Constants.titlePadding)

        announceLabel.pinTop(to: titleLabel.bottomAnchor, Constants.announcePadding)
        announceLabel.pinLeft(to: articleImageView.trailingAnchor, Constants.titlePadding)
        announceLabel.pinRight(to: contentView, Constants.titlePadding)
        announceLabel.pinBottom(to: contentView, Constants.announceBottomPadding, .lsOE)

        shimmerView.pin(to: articleImageView)
    }

    // MARK: - Image Loading
    func loadImage(from url: URL) {
        shimmerView.startAnimating() // Запускаем анимацию мерцания

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.shimmerView.stopAnimating()
                    self?.articleImageView.image = image
                    self?.fadeInImageView()
                }
            } else {
                DispatchQueue.main.async {
                    self?.shimmerView.stopAnimating()
                    self?.articleImageView.image = nil
                }
            }
        }
    }

    // MARK: - Fade In Animation
    private func fadeInImageView() {
        UIView.animate(withDuration: Constants.shimmerAnimationDuration) {
            self.articleImageView.alpha = 1
        }
    }
}
