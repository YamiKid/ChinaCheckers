import UIKit
import SnapKit

class CheckersWorldDifficultyGameViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldBigLabelBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldGameImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        setupCheckersWorldUI()
    }
    
    func setupCheckersWorldUI() {
        CheckersWorldMainBackImageView = UIImageView(image: UIImage(named: "CheckersWorldGameBack"))
        CheckersWorldMainBackImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldMainBackImageView)
        CheckersWorldMainBackImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        let CheckersWorldBackButton = UIButton()
        CheckersWorldBackButton.setImage(UIImage(named: "CheckersWorldBack"), for: .normal)
        CheckersWorldBackButton.addTarget(self, action: #selector(CheckersWorldBackTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldBackButton)
        view.addSubview(CheckersWorldBackButton)
        CheckersWorldBackButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.width.height.equalTo(50)
        }
        
        CheckersWorldBigLabelBackImageView = UIImageView(image: UIImage(named: "CheckersWorldBigLabelBack"))
        CheckersWorldBigLabelBackImageView.isUserInteractionEnabled = true
        CheckersWorldBigLabelBackImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldBigLabelBackImageView)
        CheckersWorldBigLabelBackImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        CheckersWorldGameImageView = UIImageView(image: UIImage(named: "CheckersWorldGame"))
        CheckersWorldGameImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldGameImageView)
        CheckersWorldGameImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(CheckersWorldBigLabelBackImageView.snp.top)
            make.width.equalTo(130)
            make.height.equalTo(50)
        }
        
        let CheckersWorldBigWaveImageView = UIImageView(image: UIImage(named: "CheckersWorldBigWave"))
        CheckersWorldBigWaveImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldBigWaveImageView)
        CheckersWorldBigWaveImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
            
        createDifficultyButtons()
    }
    
    func createDifficultyButtons() {
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.spacing = 10
        CheckersWorldBigLabelBackImageView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        let buttonImages = ["CheckersWorldNormal", "CheckersWorldHard", "CheckersWorldExtra"]
        for imageName in buttonImages {
            let button = UIButton()
            button.setImage(UIImage(named: imageName), for: .normal)
            button.snp.makeConstraints { make in
                make.width.equalTo(150)
                make.height.equalTo(50)
            }
            button.addTarget(self, action: #selector(handleDifficultyButtonTapped(_:)), for: .touchUpInside)
            CheckersWorldAddSound(to: button)
            buttonStackView.addArrangedSubview(button)
        }
        
        let titleLabel = UILabel()
            titleLabel.text = "Select difficulty level"
            titleLabel.font = UIFont(name: "Joti One", size: 16) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
            titleLabel.textColor = .white
            titleLabel.textAlignment = .center
            CheckersWorldBigLabelBackImageView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(buttonStackView.snp.top).offset(-20)
            }
    }
    
    @objc func handleDifficultyButtonTapped(_ sender: UIButton) {
        guard let buttonImage = sender.image(for: .normal) else { return }

        if buttonImage == UIImage(named: "CheckersWorldNormal") {
            let helpViewController = CheckersWorldStartGameViewController()
            helpViewController.CheckersWorldCostPlay = 150
            self.navigationController?.pushViewController(helpViewController, animated: true)
        } else if buttonImage == UIImage(named: "CheckersWorldHard") {
            let helpViewController = CheckersWorldStartGameViewController()
            helpViewController.CheckersWorldCostPlay = 250
            self.navigationController?.pushViewController(helpViewController, animated: true)
        } else if buttonImage == UIImage(named: "CheckersWorldExtra") {
            let helpViewController = CheckersWorldStartGameViewController()
            helpViewController.CheckersWorldCostPlay = 500
            self.navigationController?.pushViewController(helpViewController, animated: true)
        }
    }
    
    @objc func CheckersWorldBackTapped() {
        let helpViewController = CheckersWorldHomeViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }

}

