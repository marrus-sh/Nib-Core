//  馃枊馃聽Nib聽Core :: Nib路Core :: Operators
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Prefix路match.
///
///  +  term Available since:
///     0路2.
infix operator ...~=: ComparisonPrecedence

/// Optional路map.
///
///  +  term Available since:
///     0路2.
infix operator ?->: CastingPrecedence

/// Exclusion.
///
///  +  term Available since:
///     0路2.
infix operator 梅: ExclusionPrecedence

/// Excluding路assignment.
///
///  +  term Available since:
///     0路2.
infix operator 梅=: AssignmentPrecedence

/// Codepoint路equal.
///
///  +  term Available since:
///     0路2.
infix operator 鈥?=鈥?: ComparisonPrecedence

/// Of.
///
///  +  term Available since:
///     0路2.
infix operator 鉁栵笍: TimesPrecedence

/// Zero路or路one路of.
///
///  +  term Available since:
///     0路2.
postfix operator ^?

/// One路of.
///
///  +  term Available since:
///     0路2.
postfix operator ^!

/// One路or路more路of.
///
///  +  term Available since:
///     0路2.
postfix operator ^+

/// Zero路or路more路of.
///
///  +  term Available since:
///     0路2.
postfix operator ^*

/// Wrapped路or路default.
///
///  +  term Available since:
///     0路2.
postfix operator ~!

/// Welformed路or路nil.
///
///  +  term Available since:
///     0路2.
postfix operator 鉂?

/// Welformed路or路throw.
///
///  +  term Available since:
///     0路2.
postfix operator 鉂楋笍

/// Valid路or路nil.
///
///  +  term Available since:
///     0路2.
postfix operator 鈦夛笍

/// Valid路or路throw.
///
///  +  term Available since:
///     0路2.
postfix operator 鈥硷笍
