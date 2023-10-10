//
//  FileSystemUtil.swift
//  AppDatabase
//
//  Created by 김동욱 on 10/10/23.
//

import Foundation

/// FileManager를 사용하여 앱 내부에 데이터를 저장하기 때문에 앱 삭제시 함께 삭제됨.
struct FileSystemUtil {
    
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    /// 앱의 Documents 디렉토리에 저장
    func write(_ fileName: String, _ text: String) {
        guard let fileUrl = documentDirectory?.appendingPathComponent(fileName, conformingTo: .data) else { return }
        try? text.data(using: .utf8)?.write(to: fileUrl)
    }
    
    /// 앱의 Documents 디렉토리에서 읽기
    func read(_ fileName: String) -> String? {
        guard let fileUrl = documentDirectory?.appendingPathComponent(fileName, conformingTo: .data) else { return nil }
        return try? String(data: Data(contentsOf: fileUrl), encoding: .utf8)
    }
    
    /// 앱의 Documents 디렉토리에서 삭제
    func delete(_ fileName: String) {
        guard let fileUrl = documentDirectory?.appendingPathComponent(fileName, conformingTo: .data) else { return }
        try? FileManager.default.removeItem(at: fileUrl)
    }
}
