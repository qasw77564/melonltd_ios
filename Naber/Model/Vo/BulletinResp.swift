
import Foundation

struct BulletinResp : Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : BulletinVo
    
    public static func toJson(account : BulletinResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(account), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> BulletinResp? {
        do {
            return try JSONDecoder().decode(BulletinResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}


struct BulletinVo : Codable {
    var title : String!
    var content_text : String!
    var bulletin_category : String!
    
    public static func toJson(account : BulletinVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(account), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> BulletinVo? {
        do {
            return try JSONDecoder().decode(BulletinVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
    
}
