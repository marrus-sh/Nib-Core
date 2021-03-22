//  🖋🍎 Nib Core :: Core :: Operators
//  ==================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Prefix·match.
///
///  +  Version:
///     0·2.
infix operator ...~=: ComparisonPrecedence

/// Exclusion.
///
///  +  Version:
///     0·2.
infix operator ÷: ExclusionPrecedence

/// Excluding·assignment.
///
///  +  Version:
///     0·2.
infix operator ÷=: AssignmentPrecedence

/// Codepoint·equal.
///
///  +  Version:
///     0·2.
infix operator •=•: ComparisonPrecedence

/// Of.
///
///  +  Version:
///     0·2.
infix operator ✖️: TimesPrecedence

/// Zero·or·one·of.
///
///  +  Version:
///     0·2.
postfix operator ^?

/// One·of.
///
///  +  Version:
///     0·2.
postfix operator ^!

/// One·or·more·of.
///
///  +  Version:
///     0·2.
postfix operator ^+

/// Zero·or·more·of.
///
///  +  Version:
///     0·2.
postfix operator ^*

/// Welformed·or·nil.
///
///  +  Version:
///     0·2.
postfix operator ❓

/// Welformed·or·throw.
///
///  +  Version:
///     0·2.
postfix operator ❗️

/// Valid·or·nil.
///
///  +  Version:
///     0·2.
postfix operator ⁉️

/// Valid·or·throw.
///
///  +  Version:
///     0·2.
postfix operator ‼️
