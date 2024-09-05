//
//  Welcome View.swift
//  Tic Tac Toe
//
//  Created by Alexander Peter Maliyakkal on 05/09/24.
//
import UIKit

class WelcomeViewController: UIViewController {

    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let startButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBackground()
        animateTitleLabel()
    }

    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(startButton)

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = "Tic-Tac-Toe"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 33)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.alpha = 0

        subtitleLabel.text = "From ALEXANDER"
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0

        startButton.setTitle("Start Game", for: .normal)
        startButton.backgroundColor = .systemBlue
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),

            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),

            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func setupBackground() {
        backgroundImageView.image = UIImage(named: "backgroundImage") // Ensure this image is in your assets
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true

        // Apply blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Add blur effect view to background image view
        backgroundImageView.addSubview(blurEffectView)
        backgroundImageView.sendSubviewToBack(blurEffectView)
    }

    private func animateTitleLabel() {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: {
            self.titleLabel.alpha = 1.0
        }) { _ in
            self.animateSubtitleLabel()
        }
    }

    private func animateSubtitleLabel() {
        UIView.animate(withDuration: 0.5, delay: 1.0, options: [.curveEaseInOut], animations: {
            self.subtitleLabel.alpha = 1.0
            self.subtitleLabel.transform = CGAffineTransform(translationX: 0, y: -20)
            self.subtitleLabel.layer.shadowColor = UIColor.white.cgColor
            self.subtitleLabel.layer.shadowRadius = 10
            self.subtitleLabel.layer.shadowOpacity = 1.0
            self.subtitleLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        }) { _ in
            // Glow animation
            UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
                self.subtitleLabel.layer.shadowOpacity = 0.0
            }, completion: nil)
        }
    }

    @objc private func startGame() {
        print("Start Game button tapped") // Debug statement
        let gameViewController = GameViewController()
        navigationController?.pushViewController(gameViewController, animated: true)
    }
}
