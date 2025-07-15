import UIKit
import SpriteKit
import AVFoundation

class CheckersWorldSound {
    func CheckersWorldPlayBackgroundMusic() {
        if UserDefaults.standard.bool(forKey: "Music") {
            CheckersWorldAudioQueue.async {
                if self.CheckersWorldBackgroundAudio?.isPlaying != true {
                    self.CheckersWorldBackgroundAudio?.stop()
                    guard let musicURL = Bundle.main.url(forResource: "CheckersWorldBack", withExtension: "mp3") else { return }
                    do {
                        self.CheckersWorldBackgroundAudio = try AVAudioPlayer(contentsOf: musicURL)
                        self.CheckersWorldBackgroundAudio?.numberOfLoops = -1
                        self.CheckersWorldBackgroundAudio?.volume = 0.1
                        self.CheckersWorldBackgroundAudio?.play()
                    } catch {
                    }
                }
            }
        }
    }
    
    private var CheckersWorldBackgroundAudio: AVAudioPlayer?
    
    static let shared = CheckersWorldSound()
    private init() {}
    
    private let CheckersWorldAudioQueue = DispatchQueue(label: "com.sound.audioQueue")
    
    func CheckersWorldPlayButtonPress() {
        
        if UserDefaults.standard.bool(forKey: "Vibrations") {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.impactOccurred()
        }
        
        if UserDefaults.standard.bool(forKey: "Sound") {
            DispatchQueue.global().async {
                guard let soundURL = Bundle.main.url(forResource: "CheckersWorldButton", withExtension: "wav") else { return }
                self.CheckersWorldAudioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
                self.CheckersWorldAudioPlayer?.prepareToPlay()
                self.CheckersWorldAudioPlayer?.volume = 0.1
                self.CheckersWorldAudioPlayer?.play()
            }
        }
    }
    func CheckersWorldResumeBackgroundMusic() {
        CheckersWorldBackgroundAudio?.play()
    }
    
    func CheckersWorldPlayWinSound() {
        if UserDefaults.standard.bool(forKey: "Sound") {
            DispatchQueue.global().async {
                guard let soundURL = Bundle.main.url(forResource: "CheckersWorldWin", withExtension: "mp3") else { return }
                self.CheckersWorldAudioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
                self.CheckersWorldAudioPlayer?.prepareToPlay()
                self.CheckersWorldAudioPlayer?.volume = 0.1
                self.CheckersWorldAudioPlayer?.play()
            }
        }
    }
    
    func CheckersWorldPlayLoseSound() {
        if UserDefaults.standard.bool(forKey: "Sound") {
            DispatchQueue.global().async {
                guard let soundURL = Bundle.main.url(forResource: "CheckersWorldLose", withExtension: "wav") else { return }
                self.CheckersWorldAudioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
                self.CheckersWorldAudioPlayer?.prepareToPlay()
                self.CheckersWorldAudioPlayer?.volume = 0.1
                self.CheckersWorldAudioPlayer?.play()
            }
        }
    }
    
    func CheckersWorldPauseBackgroundMusic() {
        CheckersWorldBackgroundAudio?.pause()
    }
    
    private var CheckersWorldAudioPlayer: AVAudioPlayer?
}

extension UIApplicationDelegate {
    
    func CheckersWorldStartBackgroundMusic() {
        CheckersWorldSound.shared.CheckersWorldPlayBackgroundMusic()
    }
    
    func CheckersWorldStopBackgroundMusic() {
        CheckersWorldSound.shared.CheckersWorldPauseBackgroundMusic()
    }
}

extension UIViewController {
    
    func CheckersWorldStartBackgroundMusic() {
        CheckersWorldSound.shared.CheckersWorldPlayBackgroundMusic()
    }
 
    func CheckersWorldStopBackgroundMusic() {
        CheckersWorldSound.shared.CheckersWorldPauseBackgroundMusic()
    }
    
    func CheckersWorldPlayWinSound() {
        CheckersWorldSound.shared.CheckersWorldPlayWinSound()
    }
    
    func CheckersWorldPlayLoseSound() {
        CheckersWorldSound.shared.CheckersWorldPlayLoseSound()
    }
    func CheckersWorldAddSound(to button: UIButton) {
        button.addTarget(self, action: #selector(CheckersWorldHandleButtonTouchDown(sender:)), for: .touchDown)
    }
    
    @objc private func CheckersWorldHandleButtonTouchDown(sender: UIButton) {
        CheckersWorldSound.shared.CheckersWorldPlayButtonPress()
    }
}
