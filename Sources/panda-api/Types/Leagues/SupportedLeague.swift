//
//  SupportedLeague.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public enum SupportedLeague: Int, CaseIterable {
    var majorRegions: [SupportedLeague] {
        return [.na, .eu, .lck, .lpl, .lms, .gpl, .cblol, .lcl, .ljl, .lla, .lln, .cls, .opl, .tcl, .vcs]
    }
    var isMajorRegion: Bool {
        return majorRegions.contains(self)
    }
    var tournaments: [SupportedLeague] {
        return [.rr_na_eu, .rr_gpl_ljl_opl, .rr_lck_lpl_lms, .rr_lcl_tcl_vcs, .rr_lln_cls_cblol, .worlds]
    }
    var isTournament: Bool {
        return tournaments.contains(self)
    }
    var rrForRegion: SupportedLeague? {
        switch self {
        case .na, .eu          : return .rr_na_eu
        case .lck, .lpl, .lms  : return .rr_lck_lpl_lms
        case .lln, .cls, .cblol: return .rr_lln_cls_cblol
        case .lcl, .tcl, .vcs  : return .rr_lcl_tcl_vcs
        case .gpl, .ljl, .opl  : return .rr_gpl_ljl_opl
        default: return nil
        }
    }
    // International
    /// World Championship
    case worlds = 297
    /// Mid-Season Invitational
    case msi = 300
    // - Rift Rivals
    /// Rift Rivals: LCK v LPL v LMS
    case rr_lck_lpl_lms = 4097
    /// Rift Rivals: NA v EU
    case rr_na_eu = 2107
    /// Rift Rivals: LLN v CLS v CBLOL
    case rr_lln_cls_cblol = 2133
    /// Rift Rivals: LCL v TCL v VCS
    case rr_lcl_tcl_vcs = 2132
    /// Rift Rivals: SEA(GPL) v LJL v OPL
    case rr_gpl_ljl_opl = 2108
    
    // NA
    /// LCS (NALCS)
    case na = 4198
    /// NALCS (old LCS)
    case nalcs = 289
    /// NA Academy
    case naacademy = 4104
    /// NA Challenger (old Academy)
    case nachallenger = 291
    
    // EU
    /// LEC (EULCS)
    case eu = 4197
    /// EULCS (old LEC)
    case eulcs = 290
    /// EU Masters
    case eumasters = 4139
    // EU Challenger (old Masters)
    case euchallenger = 292
    /// SuperLiga Orange
    case lvp_slo = 4213
    
    // South Korea
    /// LCK
    case lck = 293
    /// Challenger Korea
    case koreachallenger = 4142
    
    // China
    /// LPL
    case lpl = 294
    
    // LMS
    /// LMS (LoL Masters Series)
    case lms = 295
    
    // SEA
    /// GPL (Garena Premier League)
    case gpl = 4180
    
    // Brazil
    /// CBLOL
    case cblol = 302
    
    // CIS
    /// LCL
    case lcl = 4004
    
    // Japan
    /// LJL
    case ljl = 2092
    
    // LAT
    /// LLA (Liga Latinoamerica)
    case lla = 4199
    
    // LAN
    /// LLN (Liga Latinoamerica Norte)
    case lln = 1002
    
    // LAS
    /// CLS (Copa Latinoamerica Norta)
    case cls = 305
    
    // OCE
    // OPL (Oceanic Pro League)
    case opl = 301
    
    // Turkey
    /// Turkish Champions League
    case tcl = 1003
    /// Turkish Promotion League
    case tcs = 1089
    
    // Vietnam
    /// VCS (Vietnam Championship Series)
    case vcs = 4141
}
