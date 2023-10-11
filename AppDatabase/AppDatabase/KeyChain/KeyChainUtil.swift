//
//  KeyChainUtil.swift
//  AppDatabase
//
//  Created by 김동욱 on 10/11/23.
//

import Foundation
import Security

struct KeyChainUtil {
    
    static func writeToKeyChain(_ service: String, _ key: String, _ text: String) {
        guard !isExist(service, key) else { updateToKeyChain(service, key, text); return }
        guard let data = text.data(using: .utf8) else { return }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecValueData: data
        ]
        
        var result: CFTypeRef? // a reference to the newly added items.
        
        // SecItemAdd()가 반환하는 결과: Security Framework Result Codes 참고
        let status = SecItemAdd(query as CFDictionary, &result)
        
        dump(result)
        
        if status == errSecSuccess {
            print("데이터가 Keychain에 추가되었습니다.")
        } else {
            print("데이터를 Keychain에 추가하는 데 실패했습니다. 오류 코드: \(status)")
        }
    }
    
    static func readFromKeyChain(_ service: String, _ key: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var data: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &data)
        
        if status == errSecSuccess {
            if let retrievedData = data as? Data {
                return String(data: retrievedData, encoding: .utf8)
            }
        } else {
            print("데이터를 KeyChain에서 읽지 못했습니다. 오류 코드: \(status)")
        }
        
        return nil
    }
    
    static func deleteFromKeychain(_ service: String, _ key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key
        ]

        let status = SecItemDelete(query as CFDictionary)

        if status == errSecSuccess {
            print("데이터가 Keychain에서 삭제되었습니다.")
        } else {
            print("데이터를 Keychain에서 삭제하는 데 실패했습니다. 오류 코드: \(status)")
        }
    }
}

// MARK: - Private.
private extension KeyChainUtil {
    static func isExist(_ service: String, _ key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanFalse as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        switch status {
        case errSecSuccess:
            return true
        case errSecItemNotFound:
            return false
        default:
            print("Keychain에서 데이터 확인 중 오류 발생. 오류 코드: \(status)")
            return false
        }
    }
    
    static func updateToKeyChain(_ service: String, _ key: String, _ text: String) {
        guard let data = text.data(using: .utf8) else { return }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key
        ]
        
        let updateQuery: [CFString: Any] = [
            kSecValueData: data
        ]
        
        let status = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
        
        if status == errSecSuccess {
            print("데이터가 KeyChain에서 업데이트되었습니다.")
        } else {
            print("데이터를 KeyChain에서 업데이트하지 못했습니다.")
        }
    }
}
