import UIKit

public protocol OnboardingKitDelegate: AnyObject {
    func nextButtonDidTap(index: Int)
    func getStartedButtonDidTap()
}

public class OnBoardingKit {
    
    // MARK: - Properties
    private lazy var onboardingViewController: OnBoardingViewController = {
        let vc = OnBoardingViewController(slides: slides, tintColor: tintColor)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        vc.nextButtonDidTap = { [weak self] idx in
            self?.delegate?.nextButtonDidTap(index: idx)
        }
        
        vc.getStartedButtonDidTap = { [weak self] in
            self?.delegate?.getStartedButtonDidTap()
        }
        
        return vc
    }()
    
    private let slides: [Slide]
    private let tintColor: UIColor
        
    public weak var delegate: OnboardingKitDelegate?
    
    private var rootVC: UIViewController?
    
    // MARK: - Init
    public init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
    }
    
    public func launchOnboarding(rootVC: UIViewController) {
        self.rootVC = rootVC
        rootVC.present(onboardingViewController, animated: true)
    }
    
    public func dismissOnboarding() {
        onboardingViewController.stopAnimation()
        
        if rootVC?.presentedViewController == onboardingViewController {
            onboardingViewController.dismiss(animated: true)
        }
    }
}
