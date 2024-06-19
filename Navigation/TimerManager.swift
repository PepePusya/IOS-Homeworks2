//
//  TimerManager.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/17.
//

import Foundation
import UIKit

class TimerManager {
    static let shared = TimerManager()
    private var timer: Timer?
    
    private init() {}
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func timerFired() {
        // Показать уведомление пользователю
        NotificationCenter.default.post(name: Notification.Name("showBreakReminder"), object: nil)
        stopTimer()
    }
}
