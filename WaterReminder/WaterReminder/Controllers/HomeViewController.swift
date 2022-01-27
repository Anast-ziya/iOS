//
//  HomeViewController.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 11.11.21.
//

import UIKit

import UIKit

protocol UpdateProgressCircle {
    func updateProgressCircle()
}

final class HomeViewController: UIViewController {

    @IBOutlet private weak var titleFactLabel: UIView!
    @IBOutlet private weak var factLabel: UILabel!
    @IBOutlet private weak var circularWaterConsumptionLabel: UILabel!
    @IBOutlet private weak var linearWaterConsumptionLabel: UILabel!
    @IBOutlet private weak var progressCircleView: ProgressCircleView!
    @IBOutlet private weak var progressCircleContainer: UIView!
    @IBOutlet private weak var linearProgressView: UIProgressView!
    
    let deviceHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let minimumHeight = deviceHeight > 740
        if minimumHeight {
            //hide the linear progress view and draw the circular progress view
            progressCircleView.createCircularPath()
            linearWaterConsumptionLabel.isHidden = minimumHeight
            linearProgressView.isHidden = minimumHeight
        } else {
            // don't draw the circular progress view and hide interesting fact
            titleFactLabel.isHidden = true
            factLabel.isHidden = true
            circularWaterConsumptionLabel.isHidden = !minimumHeight
            linearProgressView.transform = linearProgressView.transform.scaledBy(x: 1, y: 2.5)
        }
        
        
        WaterManager.shared.delegate = self
        PreferencesManager.shared.delegate = self

        if PreferencesManager.shared.currentUserPrefrences == nil {
            performSegue(withIdentifier: "welcomeScreen", sender: self)
        }
        
        updateUI()
    }
    
    @IBAction func deleteLastWasPressed(_ sender: UIButton) {
        WaterManager.shared.deleteLast()
    }
    
    //update the UI to display the daily water consumption
    func updateUI() {
        guard var goalsProgress = WaterManager.shared.goalsProgress else { return }
        
        if goalsProgress.isNaN {
            goalsProgress = 0.0
        }
        
        let labelText = "\(Int(goalsProgress * 100))% of \(PreferencesManager.shared.unitDisplayed)"
        
        circularWaterConsumptionLabel.text = labelText
        linearWaterConsumptionLabel.text = labelText
        linearProgressView.progress = goalsProgress
        progressCircleView.progressAnimation(duration: 0.6)
    }
    
}

extension HomeViewController: WaterManagerDelegate {
    func waterHistoryChanged() {
        updateUI()
    }
}

extension HomeViewController: PreferenceDelegate {
    func userPreferencesChanged() {
        updateUI()
    }
}

