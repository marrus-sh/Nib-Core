//  🖋🥑 Nib Core :: Nib·Core :: Operators
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Prefix·match.
///
///  +  term Available since:
///     0·2.
infix operator ...~=: ComparisonPrecedence

/// Optional·map.
///
///  +  term Available since:
///     0·2.
infix operator ?->: CastingPrecedence

/// Exclusion.
///
///  +  term Available since:
///     0·2.
infix operator ÷: ExclusionPrecedence

/// Excluding·assignment.
///
///  +  term Available since:
///     0·2.
infix operator ÷=: AssignmentPrecedence

/// Codepoint·equal.
///
///  +  term Available since:
///     0·2.
infix operator •=•: ComparisonPrecedence

/// Of.
///
///  +  term Available since:
///     0·2.
infix operator ✖️: TimesPrecedence

/// Zero·or·one·of.
///
///  +  term Available since:
///     0·2.
postfix operator ^?

/// One·of.
///
///  +  term Available since:
///     0·2.
postfix operator ^!

/// One·or·more·of.
///
///  +  term Available since:
///     0·2.
postfix operator ^+

/// Zero·or·more·of.
///
///  +  term Available since:
///     0·2.
postfix operator ^*

/// Wrapped·or·default.
///
///  +  term Available since:
///     0·2.
postfix operator ~!

/// Welformed·or·nil.
///
///  +  term Available since:
///     0·2.
postfix operator ❓

/// Welformed·or·throw.
///
///  +  term Available since:
///     0·2.
postfix operator ❗️

/// Valid·or·nil.
///
///  +  term Available since:
///     0·2.
postfix operator ⁉️

/// Valid·or·throw.
///
///  +  term Available since:
///     0·2.
postfix operator ‼️
