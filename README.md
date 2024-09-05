Tic-Tac-Toe Game (iOS)

Welcome to the Tic-Tac-Toe game app, designed for iOS, with a modern UI and various cool features!

Screens:

SplashScreenViewController: Displays an animated logo video on launch. After playback, transitions to the WelcomeViewController.
WelcomeViewController: Presents the app title, subtitle, and a "Start Game" button. Animates the title and subtitle upon loading. Clicking the button starts the game.
Features:

Tile Button (TileButton.swift): A custom button class used for the game board tiles (not implemented in this code). It provides features like:
Translucent white background with rounded corners.
Border and shadow for definition.
Black title text for better contrast.
Subtle animation on touch with color change.
Cross-dissolve animation when setting the symbol (X or O).
Navigation:

The app starts with the SplashScreenViewController.
After the video finishes, it transitions to the WelcomeViewController using a cross-dissolve animation.
Clicking the "Start Game" button in the WelcomeViewController is expected to launch the game screen (not implemented in this code). A placeholder navigation to a dummy GameViewController is included for demonstration.
Dependencies:

AVKit (for video playback in SplashScreenViewController)
Running the App:

Ensure you have an MP4 video file named "logovideos.mp4" in your project's resources.
