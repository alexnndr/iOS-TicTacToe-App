//
//  SplashScreen.swift
//  Tic Tac Toe
//
//  Created by Alexander Peter Maliyakkal on 05/09/24.
//
import Foundation
import UIKit
import AVKit

class SplashScreenViewController: UIViewController {

    private let playerView = AVPlayerLayer()
    private var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateLogo()
    }

    private func setupUI() {
        view.backgroundColor = .black // Set background color

        // Replace "yourAnimatedLogo.mp4" with the actual MP4 file name
        guard let url = Bundle.main.url(forResource: "logovideos", withExtension: "mp4") else {
            print("Video file not found")
            return
        }
        player = AVPlayer(url: url)
        playerView.player = player
        playerView.frame = view.bounds
        playerView.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerView)
    }

    private func animateLogo() {
        // Start playing the animation
        player?.play()

        // Listen for the end of the video
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinish), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }

    @objc private func videoDidFinish() {
        // Move to the Welcome screen after the animation completes
        goToWelcomeScreen()
    }

    private func goToWelcomeScreen() {
        // Navigate to the Welcome screen
        let welcomeVC = WelcomeViewController()
        welcomeVC.modalTransitionStyle = .crossDissolve
        welcomeVC.modalPresentationStyle = .fullScreen
        self.present(welcomeVC, animated: true, completion: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
