//
//  GameViewController.swift
//  Tic Tac Toe
//
//  Created by Alexander Peter Maliyakkal on 05/09/24.
//
import UIKit

enum Player {
    case x, o
}

class GameViewController: UIViewController {

    let tileSize: CGFloat = 100
    var tiles: [[TileButton]] = []
    var currentPlayer: Player = .x
    var scoreX: Int = 0
    var scoreO: Int = 0
    
    // Haptic feedback generator
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        // Set up blurred background
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "backgroundImage") // Ensure this image is in your assets
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        // Apply blur effect
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        
        setupTiles()
        addScoreTable()
    }

    private func setupTiles() {
        let gridSpacing: CGFloat = 10
        let totalSize = tileSize * 3 + gridSpacing * 2

        let containerView = UIView(frame: CGRect(x: (view.frame.width - totalSize) / 2, y: (view.frame.height - totalSize - 150) / 2, width: totalSize, height: totalSize))
        containerView.backgroundColor = .clear
        view.addSubview(containerView)

        for row in 0..<3 {
            var rowTiles: [TileButton] = []
            for col in 0..<3 {
                let tile = TileButton(frame: CGRect(x: CGFloat(col) * (tileSize + gridSpacing), y: CGFloat(row) * (tileSize + gridSpacing), width: tileSize, height: tileSize))
                tile.addTarget(self, action: #selector(tileTapped(_:)), for: .touchUpInside)
                containerView.addSubview(tile)
                rowTiles.append(tile)
            }
            tiles.append(rowTiles)
        }
    }

    private func addScoreTable() {
        let scoreTable = UIView()
        scoreTable.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.7)
        scoreTable.layer.cornerRadius = 10
        scoreTable.layer.borderWidth = 1
        scoreTable.layer.borderColor = UIColor.lightGray.cgColor
        scoreTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreTable)

        let playerScoreLabel = UILabel()
        playerScoreLabel.text = "X Scored: \(scoreX) | O Scored: \(scoreO)"
        playerScoreLabel.textAlignment = .center
        playerScoreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        playerScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreTable.addSubview(playerScoreLabel)

        NSLayoutConstraint.activate([
            scoreTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            scoreTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreTable.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            scoreTable.heightAnchor.constraint(equalToConstant: 100),

            playerScoreLabel.centerXAnchor.constraint(equalTo: scoreTable.centerXAnchor),
            playerScoreLabel.centerYAnchor.constraint(equalTo: scoreTable.centerYAnchor),
        ])
    }

    @objc private func tileTapped(_ sender: TileButton) {
        guard sender.title(for: .normal) == nil else { return }

        let symbol = currentPlayer == .x ? "X" : "O"
        sender.animateToSymbol(symbol: symbol)
        
        // Provide haptic feedback for a move
        impactFeedbackGenerator.impactOccurred()

        // Check for win or draw
        if checkForWin() {
            let winner = currentPlayer == .x ? "X" : "O"
            notificationFeedbackGenerator.notificationOccurred(.success) // Haptic feedback for win
            showAlert(title: "Game Over", message: "Player \(winner) wins!")
            updateScore(for: currentPlayer)
        } else if checkForDraw() {
            notificationFeedbackGenerator.notificationOccurred(.warning) // Haptic feedback for draw
            showAlert(title: "Game Over", message: "It's a draw!")
        }

        // Switch player
        currentPlayer = (currentPlayer == .x) ? .o : .x
    }

    private func checkForWin() -> Bool {
        let winningCombos: [[TileButton]] = [
            // Rows
            tiles[0], tiles[1], tiles[2],
            // Columns
            [tiles[0][0], tiles[1][0], tiles[2][0]],
            [tiles[0][1], tiles[1][1], tiles[2][1]],
            [tiles[0][2], tiles[1][2], tiles[2][2]],
            // Diagonals
            [tiles[0][0], tiles[1][1], tiles[2][2]],
            [tiles[0][2], tiles[1][1], tiles[2][0]]
        ]

        for combo in winningCombos {
            if let firstTitle = combo.first?.title(for: .normal), combo.allSatisfy({ $0.title(for: .normal) == firstTitle }) {
                return true
            }
        }
        return false
    }

    private func checkForDraw() -> Bool {
        return tiles.flatMap { $0 }.allSatisfy { $0.title(for: .normal) != nil }
    }

    private func updateScore(for player: Player) {
        if player == .x {
            scoreX += 1
        } else {
            scoreO += 1
        }
        updateScoreLabel()
    }

    private func updateScoreLabel() {
        if let scoreTable = view.subviews.first(where: { $0 is UIView && $0.subviews.contains(where: { $0 is UILabel }) }) as? UIView {
            if let playerScoreLabel = scoreTable.subviews.first(where: { $0 is UILabel }) as? UILabel {
                playerScoreLabel.text = "X Scored: \(scoreX) | O Scored: \(scoreO)"
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.resetGame()
        }))
        present(alert, animated: true, completion: nil)
    }

    private func resetGame() {
        for row in tiles {
            for tile in row {
                tile.setTitle(nil, for: .normal)
                tile.isUserInteractionEnabled = true
            }
        }
        currentPlayer = .x
    }
}
