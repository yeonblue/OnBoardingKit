# OnboardingKit

OnboardingKit provides an onboarding flow that is simple and easy to implement.
![video-preview](https://github.com/yeonblue/OnBoardingKit/raw/Main/sample.gif)

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

## Requirements

- iOS 15.0 or later
- Xcode 13.0 or later
- Swift 5.0 or later


## Installation
There are two ways to use OnboardingKit in your project:
- using Swift Package Manager
- manual install (build frameworks or embed Xcode Project)

### Swift Package Manager

To integrate OnboardingKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yeonblue/OnBoardingKit", .upToNextMajor(from: "1.0.0"))
]
```

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

### Manually

If you prefer not to use Swift Package Manager, you can integrate OnboardingKit into your project manually.

---

## Usage

### Quick Start

```swift
import UIKit
import OnBoardingKit

class ViewController: UIViewController {

    private var onboardingKit: OnBoardingKit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.onboardingKit = OnBoardingKit(slides: [
                .init(image: UIImage(named: "imSlide1")!,
                      title: "Personalised offers at 40,000+ places"),
                .init(image: UIImage(named: "imSlide2")!,
                      title: "Stack your rewards every time you pay"),
                .init(image: UIImage(named: "imSlide3")!,
                      title: "Enjoy now, Pay Later"),
                .init(image: UIImage(named: "imSlide4")!,
                      title: "Earn cashback with your physical card"),
                .init(image: UIImage(named: "imSlide5")!,
                      title: "Save and earn cashback with Deals or eCards")
            ], tintColor: UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0))
            self.onboardingKit?.delegate = self
            self.onboardingKit?.launchOnboarding(rootVC: self)
        }
    }
}

extension ViewController: OnboardingKitDelegate {
    func nextButtonDidTap(index: Int) {
        print("nextButtonDidTap - \(index)")
    }
    
    func getStartedButtonDidTap() {
        onboardingKit?.dismissOnboarding()
        onboardingKit = nil
        
        let foregroundScenes = UIApplication.shared.connectedScenes.filter {
            $0.activationState == .foregroundActive
        }
        
        let window = foregroundScenes.map {$0 as? UIWindowScene }
            .compactMap { $0 }
            .first?
            .windows
            .filter { $0.isKeyWindow }
            .first
        
        guard let window = window else { return }
        window.rootViewController = MainViewController()
        
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "This is MainViewController"
        
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

```
