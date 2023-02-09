import UIKit

public class OnBoardingKit {
    
    // MARK: - Properties
    private lazy var onboardingViewController: OnBoardingViewController = {
        let vc = OnBoardingViewController(slides: slides, tintColor: tintColor)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        return vc
    }()
    
    private let slides: [Slide]
    private let tintColor: UIColor
        
    // MARK: - Init
    public init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
    }
    
    public func launchOnboarding(rootVC: UIViewController) {
        rootVC.present(onboardingViewController, animated: true)
    }
    
    public func dismissOnboarding() {
        
    }
}
