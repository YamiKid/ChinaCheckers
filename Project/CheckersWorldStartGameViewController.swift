import UIKit
import SnapKit

class CheckersWorldStartGameViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldCostPlay = 0

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
        
        let CheckersWorldDescImageView = UIImageView(image: UIImage(named: "CheckersWorldDesc1"))
        CheckersWorldDescImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldDescImageView)
        CheckersWorldDescImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.height.equalTo(300)
        }
        
        let CheckersWorldStartPlayButton = UIButton()
        CheckersWorldStartPlayButton.setImage(UIImage(named: "CheckersWorldStartPlay"), for: .normal)
        CheckersWorldStartPlayButton.addTarget(self, action: #selector(handleStartPlayTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldStartPlayButton)
        view.addSubview(CheckersWorldStartPlayButton)
        CheckersWorldStartPlayButton.snp.makeConstraints { make in
            make.centerY.equalTo(CheckersWorldDescImageView.snp.centerY)
            make.right.equalTo(CheckersWorldDescImageView.snp.left).offset(-50)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        let costLabel = UILabel()
        costLabel.text = "\(CheckersWorldCostPlay)"
        costLabel.font = UIFont(name: "Joti One", size: 20) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        costLabel.textColor = UIColor(red: 1.0, green: 0.93, blue: 0.69, alpha: 1.0)
        costLabel.textAlignment = .center
        view.addSubview(costLabel)
        costLabel.snp.makeConstraints { make in
            make.bottom.equalTo(CheckersWorldStartPlayButton.snp.top).offset(-10)
            make.centerX.equalTo(CheckersWorldStartPlayButton.snp.centerX)
        }

        let flowerImageView = UIImageView(image: UIImage(named: "CheckersWorldFlower"))
        flowerImageView.contentMode = .scaleAspectFit
        view.addSubview(flowerImageView)
        flowerImageView.snp.makeConstraints { make in
            make.centerY.equalTo(costLabel.snp.centerY)
            make.right.equalTo(costLabel.snp.left).offset(-5)
            make.width.height.equalTo(20)
        }
    }
    
    @objc func handleStartPlayTapped() {
        let currentBalance = UserDefaults.standard.integer(forKey: "CheckersWorldScore")

        if currentBalance >= CheckersWorldCostPlay {
            let newBalance = currentBalance - CheckersWorldCostPlay
            UserDefaults.standard.set(newBalance, forKey: "CheckersWorldScore")
            
            let helpViewController = CheckersWorldGameViewController()
            self.navigationController?.setViewControllers([helpViewController], animated: true)
        } else {
            let alert = UIAlertController(
                title: "Insufficient Balance",
                message: "You don't have enough balance to start the game.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    
    @objc func CheckersWorldBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}

