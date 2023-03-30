// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let awemes = try Awemes(json)

import Foundation
import AVKit

// MARK: - Awemes
struct Awemes: Codable {
    var code: Int?
    var message: String?
    var data: [Datum]?
    var totalCount, hasMore: Int?

    enum CodingKeys: String, CodingKey {
        case code, message, data
        case totalCount = "total_count"
        case hasMore = "has_more"
    }
}

// MARK: Awemes convenience initializers and mutators

extension Awemes {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Awemes.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        code: Int? = nil,
        message: String? = nil,
        data: [Datum]? = nil,
        totalCount: Int? = nil,
        hasMore: Int? = nil
    ) -> Awemes {
        return Awemes(
            code: code ?? self.code,
            message: message ?? self.message,
            data: data ?? self.data,
            totalCount: totalCount ?? self.totalCount,
            hasMore: hasMore ?? self.hasMore
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Datum
struct Datum: Codable {
    var awemeID: String?
//    var riskInfos: RiskInfos?
//    var labelTop: LabelTop?
    var authorUserID, rate, createTime: Int?
    var video: Video?
    var canPlay, isVR: Bool?
    var vrType: Int?
    var statistics: Statistics?
    var author: Author?
    var cmtSWT: Bool?
    var shareURL: String?
    var isAds: Bool?
    var music: Music?
    var bodydanceScore: Int?
    var lawCriticalCountry: Bool?
    var isHashTag: Int?
    var status: Status?
    var sortLabel: String?
    var descendants: Descendants?
//    var shareInfo: ShareInfo?
    var isTop, awemeType: Int?
    var desc: String?
    var scenario: Int?
    var region: String?
    var isPgcshow, isRelieve: Bool?
    var userDigged: Int?
    var chaList: ChaList?

    enum CodingKeys: String, CodingKey {
        case awemeID = "aweme_id"
//        case riskInfos = "risk_infos"
//        case labelTop = "label_top"
        case authorUserID = "author_user_id"
        case rate
        case createTime = "create_time"
        case video
        case canPlay = "can_play"
        case isVR = "is_vr"
        case vrType = "vr_type"
        case statistics
        case author
        case cmtSWT = "cmt_swt"
        case shareURL = "share_url"
        case isAds = "is_ads"
        case music
        case bodydanceScore = "bodydance_score"
        case lawCriticalCountry = "law_critical_country"
        case isHashTag = "is_hash_tag"
        case status
        case sortLabel = "sort_label"
        case descendants
//        case shareInfo = "share_info"
        case isTop = "is_top"
        case awemeType = "aweme_type"
        case desc, scenario, region
        case isPgcshow = "is_pgcshow"
        case isRelieve = "is_relieve"
        case userDigged = "user_digged"
        case chaList = "cha_list"
    }
}

// MARK: Datum convenience initializers and mutators

extension Datum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Datum.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        awemeID: String? = nil,
//        riskInfos: RiskInfos? = nil,
//        labelTop: LabelTop? = nil,
        authorUserID: Int? = nil,
        rate: Int? = nil,
        createTime: Int? = nil,
        video: Video? = nil,
        canPlay: Bool? = nil,
        isVR: Bool? = nil,
        vrType: Int? = nil,
        statistics: Statistics? = nil,
        author: Author? = nil,
        cmtSWT: Bool? = nil,
        shareURL: String? = nil,
        isAds: Bool? = nil,
        music: Music? = nil,
        bodydanceScore: Int? = nil,
        lawCriticalCountry: Bool? = nil,
        isHashTag: Int? = nil,
        status: Status? = nil,
        sortLabel: String? = nil,
        descendants: Descendants? = nil,
//        shareInfo: ShareInfo? = nil,
        isTop: Int? = nil,
        awemeType: Int? = nil,
        desc: String? = nil,
        scenario: Int? = nil,
        region: String? = nil,
        isPgcshow: Bool? = nil,
        isRelieve: Bool? = nil,
        userDigged: Int? = nil,
        chaList: ChaList? = nil
    ) -> Datum {
        return Datum(
            awemeID: awemeID ?? self.awemeID,
//            riskInfos: riskInfos ?? self.riskInfos,
//            labelTop: labelTop ?? self.labelTop,
            authorUserID: authorUserID ?? self.authorUserID,
            rate: rate ?? self.rate,
            createTime: createTime ?? self.createTime,
            video: video ?? self.video,
            canPlay: canPlay ?? self.canPlay,
            isVR: isVR ?? self.isVR,
            vrType: vrType ?? self.vrType,
            statistics: statistics ?? self.statistics,
            author: author ?? self.author,
            cmtSWT: cmtSWT ?? self.cmtSWT,
            shareURL: shareURL ?? self.shareURL,
//            isAds: isAds ?? self.isAds,
            music: music ?? self.music,
            bodydanceScore: bodydanceScore ?? self.bodydanceScore,
            lawCriticalCountry: lawCriticalCountry ?? self.lawCriticalCountry,
            isHashTag: isHashTag ?? self.isHashTag,
            status: status ?? self.status,
            sortLabel: sortLabel ?? self.sortLabel,
            descendants: descendants ?? self.descendants,
//            shareInfo: shareInfo ?? self.shareInfo,
            isTop: isTop ?? self.isTop,
            awemeType: awemeType ?? self.awemeType,
            desc: desc ?? self.desc,
            scenario: scenario ?? self.scenario,
            region: region ?? self.region,
            isPgcshow: isPgcshow ?? self.isPgcshow,
            isRelieve: isRelieve ?? self.isRelieve,
            userDigged: userDigged ?? self.userDigged,
            chaList: chaList ?? self.chaList
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

struct Descendants: Codable {
    var notify_msg: String
    var platforms: [String]
    
    enum CodingKeys: String, CodingKey {
        case notify_msg
        case platforms = "platforms"
    }
}

extension Descendants {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Descendants.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        notify_msg: String? = nil,
        platforms: [String]? = nil
    ) -> Descendants {
        return Descendants(
            notify_msg: notify_msg ?? self.notify_msg,
            platforms: platforms ?? self.platforms
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ChaListElement
struct ChaListElement: Codable {
    var userCount: Int?
    var cid: String?
    var isPgcshow: Bool?
    var chaName, schema: String?
    var type, subType: Int?
    var desc: String?

    enum CodingKeys: String, CodingKey {
        case userCount = "user_count"
        case cid
        case isPgcshow = "is_pgcshow"
        case chaName = "cha_name"
        case schema, type
        case subType = "sub_type"
        case desc
    }
}

// MARK: ChaListElement convenience initializers and mutators

extension ChaListElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ChaListElement.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        userCount: Int?? = nil,
        cid: String?? = nil,
        isPgcshow: Bool?? = nil,
        chaName: String?? = nil,
        schema: String?? = nil,
        type: Int?? = nil,
        subType: Int?? = nil,
        desc: String?? = nil
    ) -> ChaListElement {
        return ChaListElement(
            userCount: userCount ?? self.userCount,
            cid: cid ?? self.cid,
            isPgcshow: isPgcshow ?? self.isPgcshow,
            chaName: chaName ?? self.chaName,
            schema: schema ?? self.schema,
            type: type ?? self.type,
            subType: subType ?? self.subType,
            desc: desc ?? self.desc
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias ChaList = [ChaListElement]

// MARK: - Author
struct Author: Codable {
    var uid: String?
    var commentSetting: Int?
    var youtubeChannelTitle: String?
    var followingCount: Int?
    var shareQrcodeURI, youtubeChannelID: String?
    var avatarLarger: LabelTop?
    var enterpriseVerifyReason: String?
    var storyOpen: Bool?
    var userRate, liveVerify: Int?
    var shortID: String?
    var isGovMediaVip: Bool?
    var secret: Int?
    var accountRegion: String?
    var reflowPageGid: Int?
    var avatarThumb: LabelTop?
    var isBindedWeibo, isVerified: Bool?
    var videoIconVirtualURI: String?
    var hideSearch, withCommerceEntry: Bool?
    var schoolName, customVerify: String?
    var awemeCount, specialLock: Int?
    var userCanceled: Bool?
    var shieldCommentNotice, totalFavorited, favoritingCount: Int?
    var hideLocation: Bool?
    var gender: Int?
    var videoIcon: LabelTop?
    var schoolPoiID: String?
    var hasEmail: Bool?
    var liveAgreement: Int?
    var region: String?
    var preventDownload: Bool?
    var weiboSchema, bindPhone, weiboURL: String?
    var liveAgreementTime: Int?
    var weiboName, twitterID: String?
    var commerceUserLevel, createTime, storyCount: Int?
    var verifyInfo, googleAccount: String?
    var constellation, appleAccount: Int?
    var acceptPrivatePolicy: Bool?
    var needRecommend, shieldDiggNotice, verificationType, followerStatus: Int?
    var neiguangShield, roomID: Int?
    var avatarMedium: LabelTop?
    var followerCount, authorityStatus: Int?
    var hasOrders: Bool?
    var reflowPageUid: Int?
    var birthday: String?
    var isAdFake: Bool?
    var duetSetting: Int?
    var nickname: String?
    var shieldFollowNotice: Int?
    var originalMusicCover: JSONNull?
    var followStatus: Int?
    var insID: String?
    var uniqueIDModifyTime: Int?
    var isPhoneBinded: Bool?
    var schoolType, status: Int?
    var twitterName, avatarURI, signature, weiboVerify: String?
    var uniqueID: String?
    var geofencing: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case uid
        case commentSetting = "comment_setting"
        case youtubeChannelTitle = "youtube_channel_title"
        case followingCount = "following_count"
        case shareQrcodeURI = "share_qrcode_uri"
        case youtubeChannelID = "youtube_channel_id"
        case avatarLarger = "avatar_larger"
        case enterpriseVerifyReason = "enterprise_verify_reason"
        case storyOpen = "story_open"
        case userRate = "user_rate"
        case liveVerify = "live_verify"
        case shortID = "short_id"
        case isGovMediaVip = "is_gov_media_vip"
        case secret
        case accountRegion = "account_region"
        case reflowPageGid = "reflow_page_gid"
        case avatarThumb = "avatar_thumb"
        case isBindedWeibo = "is_binded_weibo"
        case isVerified = "is_verified"
        case videoIconVirtualURI = "video_icon_virtual_URI"
        case hideSearch = "hide_search"
        case withCommerceEntry = "with_commerce_entry"
        case schoolName = "school_name"
        case customVerify = "custom_verify"
        case awemeCount = "aweme_count"
        case specialLock = "special_lock"
        case userCanceled = "user_canceled"
        case shieldCommentNotice = "shield_comment_notice"
        case totalFavorited = "total_favorited"
        case favoritingCount = "favoriting_count"
        case hideLocation = "hide_location"
        case gender
        case videoIcon = "video_icon"
        case schoolPoiID = "school_poi_id"
        case hasEmail = "has_email"
        case liveAgreement = "live_agreement"
        case region
        case preventDownload = "prevent_download"
        case weiboSchema = "weibo_schema"
        case bindPhone = "bind_phone"
        case weiboURL = "weibo_url"
        case liveAgreementTime = "live_agreement_time"
        case weiboName = "weibo_name"
        case twitterID = "twitter_id"
        case commerceUserLevel = "commerce_user_level"
        case createTime = "create_time"
        case storyCount = "story_count"
        case verifyInfo = "verify_info"
        case googleAccount = "google_account"
        case constellation
        case appleAccount = "apple_account"
        case acceptPrivatePolicy = "accept_private_policy"
        case needRecommend = "need_recommend"
        case shieldDiggNotice = "shield_digg_notice"
        case verificationType = "verification_type"
        case followerStatus = "follower_status"
        case neiguangShield = "neiguang_shield"
        case roomID = "room_id"
        case avatarMedium = "avatar_medium"
        case followerCount = "follower_count"
        case authorityStatus = "authority_status"
        case hasOrders = "has_orders"
        case reflowPageUid = "reflow_page_uid"
        case birthday
        case isAdFake = "is_ad_fake"
        case duetSetting = "duet_setting"
        case nickname
        case shieldFollowNotice = "shield_follow_notice"
        case originalMusicCover = "original_music_cover"
        case followStatus = "follow_status"
        case insID = "ins_id"
        case uniqueIDModifyTime = "unique_id_modify_time"
        case isPhoneBinded = "is_phone_binded"
        case schoolType = "school_type"
        case status
        case twitterName = "twitter_name"
        case avatarURI = "avatar_uri"
        case signature
        case weiboVerify = "weibo_verify"
        case uniqueID = "unique_id"
        case geofencing
    }
}

// MARK: Author convenience initializers and mutators

extension Author {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Author.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        uid: String? = nil,
        commentSetting: Int? = nil,
        youtubeChannelTitle: String? = nil,
        followingCount: Int? = nil,
        shareQrcodeURI: String? = nil,
        youtubeChannelID: String? = nil,
        avatarLarger: LabelTop? = nil,
        enterpriseVerifyReason: String? = nil,
        storyOpen: Bool? = nil,
        userRate: Int? = nil,
        liveVerify: Int? = nil,
        shortID: String? = nil,
        isGovMediaVip: Bool? = nil,
        secret: Int? = nil,
        accountRegion: String? = nil,
        reflowPageGid: Int? = nil,
        avatarThumb: LabelTop? = nil,
        isBindedWeibo: Bool? = nil,
        isVerified: Bool? = nil,
        videoIconVirtualURI: String? = nil,
        hideSearch: Bool? = nil,
        withCommerceEntry: Bool? = nil,
        schoolName: String? = nil,
        customVerify: String? = nil,
        awemeCount: Int? = nil,
        specialLock: Int? = nil,
        userCanceled: Bool? = nil,
        shieldCommentNotice: Int? = nil,
        totalFavorited: Int? = nil,
        favoritingCount: Int? = nil,
        hideLocation: Bool? = nil,
        gender: Int? = nil,
        videoIcon: LabelTop? = nil,
        schoolPoiID: String? = nil,
        hasEmail: Bool? = nil,
        liveAgreement: Int? = nil,
        region: String? = nil,
        preventDownload: Bool? = nil,
        weiboSchema: String? = nil,
        bindPhone: String? = nil,
        weiboURL: String? = nil,
        liveAgreementTime: Int? = nil,
        weiboName: String? = nil,
        twitterID: String? = nil,
        commerceUserLevel: Int? = nil,
        createTime: Int? = nil,
        storyCount: Int? = nil,
        verifyInfo: String? = nil,
        googleAccount: String? = nil,
        constellation: Int? = nil,
        appleAccount: Int? = nil,
        acceptPrivatePolicy: Bool? = nil,
        needRecommend: Int? = nil,
        shieldDiggNotice: Int? = nil,
        verificationType: Int? = nil,
        followerStatus: Int? = nil,
        neiguangShield: Int? = nil,
        roomID: Int? = nil,
        avatarMedium: LabelTop? = nil,
        followerCount: Int? = nil,
        authorityStatus: Int? = nil,
        hasOrders: Bool? = nil,
        reflowPageUid: Int? = nil,
        birthday: String? = nil,
        isAdFake: Bool? = nil,
        duetSetting: Int? = nil,
        nickname: String? = nil,
        shieldFollowNotice: Int? = nil,
        originalMusicCover: JSONNull? = nil,
        followStatus: Int? = nil,
        insID: String? = nil,
        uniqueIDModifyTime: Int? = nil,
        isPhoneBinded: Bool? = nil,
        schoolType: Int? = nil,
        status: Int? = nil,
        twitterName: String? = nil,
        avatarURI: String? = nil,
        signature: String? = nil,
        weiboVerify: String? = nil,
        uniqueID: String? = nil,
        geofencing: [JSONAny]? = nil
    ) -> Author {
        return Author(
            uid: uid ?? self.uid,
            commentSetting: commentSetting ?? self.commentSetting,
            youtubeChannelTitle: youtubeChannelTitle ?? self.youtubeChannelTitle,
            followingCount: followingCount ?? self.followingCount,
            shareQrcodeURI: shareQrcodeURI ?? self.shareQrcodeURI,
            youtubeChannelID: youtubeChannelID ?? self.youtubeChannelID,
            avatarLarger: avatarLarger ?? self.avatarLarger,
            enterpriseVerifyReason: enterpriseVerifyReason ?? self.enterpriseVerifyReason,
            storyOpen: storyOpen ?? self.storyOpen,
            userRate: userRate ?? self.userRate,
            liveVerify: liveVerify ?? self.liveVerify,
            shortID: shortID ?? self.shortID,
            isGovMediaVip: isGovMediaVip ?? self.isGovMediaVip,
            secret: secret ?? self.secret,
            accountRegion: accountRegion ?? self.accountRegion,
            reflowPageGid: reflowPageGid ?? self.reflowPageGid,
            avatarThumb: avatarThumb ?? self.avatarThumb,
            isBindedWeibo: isBindedWeibo ?? self.isBindedWeibo,
            isVerified: isVerified ?? self.isVerified,
            videoIconVirtualURI: videoIconVirtualURI ?? self.videoIconVirtualURI,
            hideSearch: hideSearch ?? self.hideSearch,
            withCommerceEntry: withCommerceEntry ?? self.withCommerceEntry,
            schoolName: schoolName ?? self.schoolName,
            customVerify: customVerify ?? self.customVerify,
            awemeCount: awemeCount ?? self.awemeCount,
            specialLock: specialLock ?? self.specialLock,
            userCanceled: userCanceled ?? self.userCanceled,
            shieldCommentNotice: shieldCommentNotice ?? self.shieldCommentNotice,
            totalFavorited: totalFavorited ?? self.totalFavorited,
            favoritingCount: favoritingCount ?? self.favoritingCount,
            hideLocation: hideLocation ?? self.hideLocation,
            gender: gender ?? self.gender,
            videoIcon: videoIcon ?? self.videoIcon,
            schoolPoiID: schoolPoiID ?? self.schoolPoiID,
            hasEmail: hasEmail ?? self.hasEmail,
            liveAgreement: liveAgreement ?? self.liveAgreement,
            region: region ?? self.region,
            preventDownload: preventDownload ?? self.preventDownload,
            weiboSchema: weiboSchema ?? self.weiboSchema,
            bindPhone: bindPhone ?? self.bindPhone,
            weiboURL: weiboURL ?? self.weiboURL,
            liveAgreementTime: liveAgreementTime ?? self.liveAgreementTime,
            weiboName: weiboName ?? self.weiboName,
            twitterID: twitterID ?? self.twitterID,
            commerceUserLevel: commerceUserLevel ?? self.commerceUserLevel,
            createTime: createTime ?? self.createTime,
            storyCount: storyCount ?? self.storyCount,
            verifyInfo: verifyInfo ?? self.verifyInfo,
            googleAccount: googleAccount ?? self.googleAccount,
            constellation: constellation ?? self.constellation,
            appleAccount: appleAccount ?? self.appleAccount,
            acceptPrivatePolicy: acceptPrivatePolicy ?? self.acceptPrivatePolicy,
            needRecommend: needRecommend ?? self.needRecommend,
            shieldDiggNotice: shieldDiggNotice ?? self.shieldDiggNotice,
            verificationType: verificationType ?? self.verificationType,
            followerStatus: followerStatus ?? self.followerStatus,
            neiguangShield: neiguangShield ?? self.neiguangShield,
            roomID: roomID ?? self.roomID,
            avatarMedium: avatarMedium ?? self.avatarMedium,
            followerCount: followerCount ?? self.followerCount,
            authorityStatus: authorityStatus ?? self.authorityStatus,
            hasOrders: hasOrders ?? self.hasOrders,
            reflowPageUid: reflowPageUid ?? self.reflowPageUid,
            birthday: birthday ?? self.birthday,
            isAdFake: isAdFake ?? self.isAdFake,
            duetSetting: duetSetting ?? self.duetSetting,
            nickname: nickname ?? self.nickname,
            shieldFollowNotice: shieldFollowNotice ?? self.shieldFollowNotice,
            originalMusicCover: originalMusicCover ?? self.originalMusicCover,
            followStatus: followStatus ?? self.followStatus,
            insID: insID ?? self.insID,
            uniqueIDModifyTime: uniqueIDModifyTime ?? self.uniqueIDModifyTime,
            isPhoneBinded: isPhoneBinded ?? self.isPhoneBinded,
            schoolType: schoolType ?? self.schoolType,
            status: status ?? self.status,
            twitterName: twitterName ?? self.twitterName,
            avatarURI: avatarURI ?? self.avatarURI,
            signature: signature ?? self.signature,
            weiboVerify: weiboVerify ?? self.weiboVerify,
            uniqueID: uniqueID ?? self.uniqueID,
            geofencing: geofencing ?? self.geofencing
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LabelTop
struct LabelTop: Codable {
    var uri: String?
    var urlList: [String]?

    enum CodingKeys: String, CodingKey {
        case uri
        case urlList = "url_list"
    }
}

// MARK: LabelTop convenience initializers and mutators

extension LabelTop {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LabelTop.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        uri: String? = nil,
        urlList: [String]? = nil
    ) -> LabelTop {
        return LabelTop(
            uri: uri ?? self.uri,
            urlList: urlList ?? self.urlList
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Music
struct Music: Codable {
    var id: String?
    var uid: JSONNull?
    var status: Int?
    var extra: String?
    var isOriginal: Bool?
    var offlineDesc: String?
    var sourcePlatform: Int?
    var coverLarge: LabelTop?
    var duration: Int?
    var coverThumb, coverHD: LabelTop?
    var userCount: Int?
    var title: String?
    var playURL: LabelTop?
    var author, mid: String?
    var coverMedium: LabelTop?
    var idStr: String?
    var isRestricted: Bool?
    var schemaURL: String?

    enum CodingKeys: String, CodingKey {
        case id, uid, status, extra
        case isOriginal = "is_original"
        case offlineDesc = "offline_desc"
        case sourcePlatform = "source_platform"
        case coverLarge = "cover_large"
        case duration
        case coverThumb = "cover_thumb"
        case coverHD = "cover_hd"
        case userCount = "user_count"
        case title
        case playURL = "play_url"
        case author, mid
        case coverMedium = "cover_medium"
        case idStr = "id_str"
        case isRestricted = "is_restricted"
        case schemaURL = "schema_url"
    }
}

// MARK: Music convenience initializers and mutators

extension Music {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Music.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        uid: JSONNull? = nil,
        status: Int? = nil,
        extra: String? = nil,
        isOriginal: Bool? = nil,
        offlineDesc: String? = nil,
        sourcePlatform: Int? = nil,
        coverLarge: LabelTop? = nil,
        duration: Int? = nil,
        coverThumb: LabelTop? = nil,
        coverHD: LabelTop? = nil,
        userCount: Int? = nil,
        title: String? = nil,
        playURL: LabelTop? = nil,
        author: String? = nil,
        mid: String? = nil,
        coverMedium: LabelTop? = nil,
        idStr: String? = nil,
        isRestricted: Bool? = nil,
        schemaURL: String? = nil
    ) -> Music {
        return Music(
            id: id ?? self.id,
            uid: uid ?? self.uid,
            status: status ?? self.status,
            extra: extra ?? self.extra,
            isOriginal: isOriginal ?? self.isOriginal,
            offlineDesc: offlineDesc ?? self.offlineDesc,
            sourcePlatform: sourcePlatform ?? self.sourcePlatform,
            coverLarge: coverLarge ?? self.coverLarge,
            duration: duration ?? self.duration,
            coverThumb: coverThumb ?? self.coverThumb,
            coverHD: coverHD ?? self.coverHD,
            userCount: userCount ?? self.userCount,
            title: title ?? self.title,
            playURL: playURL ?? self.playURL,
            author: author ?? self.author,
            mid: mid ?? self.mid,
            coverMedium: coverMedium ?? self.coverMedium,
            idStr: idStr ?? self.idStr,
            isRestricted: isRestricted ?? self.isRestricted,
            schemaURL: schemaURL ?? self.schemaURL
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RiskInfos
struct RiskInfos: Codable {
    var warn: Bool?
    var content: String?
    var riskSink: Bool?
    var type: Int?

    enum CodingKeys: String, CodingKey {
        case warn, content
        case riskSink = "risk_sink"
        case type
    }
}

// MARK: RiskInfos convenience initializers and mutators

extension RiskInfos {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RiskInfos.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        warn: Bool? = nil,
        content: String? = nil,
        riskSink: Bool? = nil,
        type: Int? = nil
    ) -> RiskInfos {
        return RiskInfos(
            warn: warn ?? self.warn,
            content: content ?? self.content,
            riskSink: riskSink ?? self.riskSink,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ShareInfo
struct ShareInfo: Codable {
    var shareWeiboDesc, shareTitle: String?
    var shareURL: String?
    var shareDesc: String?

    enum CodingKeys: String, CodingKey {
        case shareWeiboDesc = "share_weibo_desc"
        case shareTitle = "share_title"
        case shareURL = "share_url"
        case shareDesc = "share_desc"
    }
}

// MARK: ShareInfo convenience initializers and mutators

extension ShareInfo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ShareInfo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        shareWeiboDesc: String? = nil,
        shareTitle: String? = nil,
        shareURL: String? = nil,
        shareDesc: String? = nil
    ) -> ShareInfo {
        return ShareInfo(
            shareWeiboDesc: shareWeiboDesc ?? self.shareWeiboDesc,
            shareTitle: shareTitle ?? self.shareTitle,
            shareURL: shareURL ?? self.shareURL,
            shareDesc: shareDesc ?? self.shareDesc
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Statistics
struct Statistics: Codable {
    var playCount: Int?
    var awemeID: String?
    var commentCount, shareCount, collectCount, diggCount: Int?

    enum CodingKeys: String, CodingKey {
        case playCount = "play_count"
        case awemeID = "aweme_id"
        case commentCount = "comment_count"
        case shareCount = "share_count"
        case diggCount = "digg_count"
        case collectCount = "collectCount"
    }
}

// MARK: Statistics convenience initializers and mutators

extension Statistics {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Statistics.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        playCount: Int? = nil,
        awemeID: String? = nil,
        commentCount: Int? = nil,
        shareCount: Int? = nil,
        diggCount: Int? = nil
    ) -> Statistics {
        return Statistics(
            playCount: playCount ?? self.playCount,
            awemeID: awemeID ?? self.awemeID,
            commentCount: commentCount ?? self.commentCount,
            shareCount: shareCount ?? self.shareCount,
            diggCount: diggCount ?? self.diggCount
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Status
struct Status: Codable {
    var withGoods, isDelete: Bool?
    var privateStatus: Int?
    var withFusionGoods, allowComment, allowShare, isPrivate: Bool?

    enum CodingKeys: String, CodingKey {
        case withGoods = "with_goods"
        case isDelete = "is_delete"
        case privateStatus = "private_status"
        case withFusionGoods = "with_fusion_goods"
        case allowComment = "allow_comment"
        case allowShare = "allow_share"
        case isPrivate = "is_private"
    }
}

// MARK: Status convenience initializers and mutators

extension Status {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Status.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        withGoods: Bool? = nil,
        isDelete: Bool? = nil,
        privateStatus: Int? = nil,
        withFusionGoods: Bool? = nil,
        allowComment: Bool? = nil,
        allowShare: Bool? = nil,
        isPrivate: Bool? = nil
    ) -> Status {
        return Status(
            withGoods: withGoods ?? self.withGoods,
            isDelete: isDelete ?? self.isDelete,
            privateStatus: privateStatus ?? self.privateStatus,
            withFusionGoods: withFusionGoods ?? self.withFusionGoods,
            allowComment: allowComment ?? self.allowComment,
            allowShare: allowShare ?? self.allowShare,
            isPrivate: isPrivate ?? self.isPrivate
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Video
struct Video: Codable {
    var id, ratio: String?
    var originCover, playAddr, cover: LabelTop?
    var height, width: Int?
    var downloadAddr: LabelTop?
    var hasWatermark: Bool?
    var duration: Int?
    var playAddrLowbr, dynamicCover: LabelTop?
    var bitRate: [BitRate]?
    var playerItems: [AVPlayerItem]?

    enum CodingKeys: String, CodingKey {
        case id, ratio
        case originCover = "origin_cover"
        case playAddr = "play_addr"
        case cover, height, width
        case downloadAddr = "download_addr"
        case hasWatermark = "has_watermark"
        case duration
        case playAddrLowbr = "play_addr_lowbr"
        case dynamicCover = "dynamic_cover"
        case bitRate = "bit_rate"
//        case playerItems = "playerItems"
    }
    
    init(id: String?,
         ratio: String?,
         originCover: LabelTop?,
         playAddr: LabelTop?,
         cover: LabelTop?,
         downloadAddr: LabelTop?,
         playAddrLowbr: LabelTop?,
         dynamicCover: LabelTop?,
         bitRate: [BitRate]?,
         height: Int?,
         width: Int?,
         hasWatermark: Bool?,
         duration: Int?,
         playerItems: [AVPlayerItem]?) {
        self.id = id
        self.ratio = ratio
        self.originCover = originCover
        self.playAddr = playAddr
        self.cover = cover
        self.downloadAddr = downloadAddr
        self.playAddrLowbr = playAddrLowbr
        self.dynamicCover = dynamicCover
        self.bitRate = bitRate
        self.height = height
        self.width = width
        self.hasWatermark = hasWatermark
        self.duration = duration
        self.playerItems = playerItems
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        ratio = try values.decode(String.self, forKey: .ratio)
        originCover = try values.decode(LabelTop.self, forKey: .originCover)
        playAddr = try values.decode(LabelTop.self, forKey: .playAddr)
        cover = try values.decode(LabelTop.self, forKey: .cover)
        downloadAddr = try values.decode(LabelTop.self, forKey: .downloadAddr)
        playAddrLowbr = try values.decode(LabelTop.self, forKey: .playAddrLowbr)
        dynamicCover = try values.decode(LabelTop.self, forKey: .dynamicCover)
        bitRate = try values.decode([BitRate].self, forKey: .bitRate)
        height = try values.decode(Int.self, forKey: .height)
        width = try values.decode(Int.self, forKey: .width)
        hasWatermark = try values.decode(Bool.self, forKey: .hasWatermark)
        duration = try values.decode(Int.self, forKey: .duration)
//        playerItems = try values.decode([AVPlayerItem].self, forKey: .playerItems)
        
        let urls = playAddr?.urlList?.compactMap({ uri in
            return URL(string: uri)
        })
        
        let items = urls?.compactMap({ url in
            return AVPlayerItem(url: url)
        })
        playerItems = items ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(ratio, forKey: .ratio)
        try container.encode(originCover, forKey: .originCover)
        try container.encode(playAddr, forKey: .playAddr)
        try container.encode(cover, forKey: .cover)
        try container.encode(downloadAddr, forKey: .downloadAddr)
        try container.encode(playAddrLowbr, forKey: .playAddrLowbr)
        try container.encode(dynamicCover, forKey: .dynamicCover)
        try container.encode(bitRate, forKey: .bitRate)
        try container.encode(height, forKey: .height)
        try container.encode(width, forKey: .width)
        try container.encode(hasWatermark, forKey: .hasWatermark)
        try container.encode(duration, forKey: .duration)
//        try container.encode(playerItems, forKey: .playerItems)
    }
    

}

// MARK: Video convenience initializers and mutators

extension Video {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Video.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func copyWith(
        id: String? = nil,
        ratio: String? = nil,
        originCover: LabelTop? = nil,
        playAddr: LabelTop? = nil,
        cover: LabelTop? = nil,
        height: Int? = nil,
        width: Int? = nil,
        downloadAddr: LabelTop? = nil,
        hasWatermark: Bool? = nil,
        duration: Int? = nil,
        playAddrLowbr: LabelTop? = nil,
        dynamicCover: LabelTop? = nil,
        bitRate: [BitRate]? = nil,
        playerItems: [AVPlayerItem]? = nil
    ) -> Video {
        return Video(id: id ?? self.id, ratio: ratio ?? self.ratio, originCover: originCover ?? self.originCover, playAddr: playAddr ?? self.playAddr, cover: cover ?? self.cover, downloadAddr: downloadAddr ?? self.downloadAddr, playAddrLowbr: playAddrLowbr ?? self.playAddrLowbr, dynamicCover: dynamicCover ?? self.dynamicCover, bitRate: bitRate ?? self.bitRate, height: height ?? self.height, width: width ?? self.width, hasWatermark: hasWatermark ?? self.hasWatermark, duration: duration ?? self.duration, playerItems: playerItems ?? self.playerItems)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
}

// MARK: - BitRate
struct BitRate: Codable {
    var bitRate: Int?
    var gearName: String?
    var qualityType: Int?

    enum CodingKeys: String, CodingKey {
        case bitRate = "bit_rate"
        case gearName = "gear_name"
        case qualityType = "quality_type"
    }
}

// MARK: BitRate convenience initializers and mutators

extension BitRate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BitRate.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        bitRate: Int? = nil,
        gearName: String? = nil,
        qualityType: Int? = nil
    ) -> BitRate {
        return BitRate(
            bitRate: bitRate ?? self.bitRate,
            gearName: gearName ?? self.gearName,
            qualityType: qualityType ?? self.qualityType
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
@propertyWrapper public struct NilOnFail<T: Codable>: Codable {
    
    public let wrappedValue: T?
    public init(from decoder: Decoder) throws {
        wrappedValue = try? T(from: decoder)
    }
    public init(_ wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
}
