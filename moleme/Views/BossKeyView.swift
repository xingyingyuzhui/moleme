//
//  BossKeyView.swift
//  moleme
//
//  Created by qin on 2026/1/16.
//

import SwiftUI

struct BossKeyView: View {
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            // Dark blue background (Windows Update style)
            Color(.sRGB, red: 0/255, green: 120/255, blue: 215/255, opacity: 1)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Windows-style loading circle
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2.0)
                
                VStack(spacing: 16) {
                    Text("正在处理更新")
                        .font(.system(size: 32, weight: .light))
                        .foregroundColor(.white)
                    
                    Text("已完成 27%")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text("请不要关闭电脑")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.top, 20)
                }
                
                Spacer()
                Spacer()
            }
        }
        .onTapGesture(count: 2) {
            // Double tap to dismiss
            withAnimation(.easeInOut(duration: 0.2)) {
                isActive = false
            }
            
            // Haptic feedback
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
        }
    }
}

// Alternative Excel-style Boss Key
struct ExcelBossKeyView: View {
    @Binding var isActive: Bool
    
    private let cellData: [[String]] = [
        ["季度", "销售额", "成本", "利润", "增长率"],
        ["Q1", "¥125,000", "¥89,000", "¥36,000", "12.5%"],
        ["Q2", "¥142,000", "¥95,000", "¥47,000", "8.3%"],
        ["Q3", "¥138,000", "¥92,000", "¥46,000", "-2.8%"],
        ["Q4", "¥156,000", "¥98,000", "¥58,000", "13.0%"],
        ["合计", "¥561,000", "¥374,000", "¥187,000", "7.8%"]
    ]
    
    var body: some View {
        ZStack {
            Color(.sRGB, red: 240/255, green: 240/255, blue: 240/255, opacity: 1)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Excel-style toolbar
                HStack {
                    Image(systemName: "doc.text")
                    Text("季度报表.xlsx")
                        .font(.system(size: 14))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color(.sRGB, red: 33/255, green: 115/255, blue: 70/255, opacity: 1))
                .foregroundColor(.white)
                
                // Excel grid
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0..<cellData.count, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<cellData[row].count, id: \.self) { col in
                                    Text(cellData[row][col])
                                        .font(.system(size: 12, design: .monospaced))
                                        .frame(width: col == 0 ? 60 : 80, height: 30)
                                        .background(row == 0 ? Color.gray.opacity(0.3) : Color.white)
                                        .border(Color.gray.opacity(0.3), width: 0.5)
                                }
                            }
                        }
                    }
                    .padding(16)
                }
                
                Spacer()
            }
        }
        .onTapGesture(count: 2) {
            withAnimation(.easeInOut(duration: 0.2)) {
                isActive = false
            }
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
        }
    }
}

#Preview {
    BossKeyView(isActive: .constant(true))
}
