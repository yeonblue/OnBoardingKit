import UIKit

public protocol OnboardingKitDelegate: AnyObject {
    func nextButtonDidTap(index: Int)
    func getStartedButtonDidTap()
}

public class OnBoardingKit {
    
    // MARK: - Properties
    private lazy var onboardingViewController: OnBoardingViewController = {
        let vc = OnBoardingViewController(slides: slides, tintColor: tintColor, themeFont: themeFont)
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
    private let themeFont: UIFont
    
    public weak var delegate: OnboardingKitDelegate?
    
    private var rootVC: UIViewController?
    
    // MARK: - Init
    public init(slides: [Slide],
                tintColor: UIColor,
                themeFont: UIFont = UIFont(name: "ArialRoundedMTBold", size: 20) ?? UIFont.systemFont(ofSize: 20)) {
        self.slides = slides
        self.tintColor = tintColor
        self.themeFont = themeFont
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
