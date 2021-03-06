//  #  Core :: Operators  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Codepoint·equal.
///
///  +  Version:
///     `0.2.0`.
infix operator •=•: ComparisonPrecedence

/// Exclusion.
///
///  +  Version:
///     `0.2.0`.
infix operator ÷: ExclusionPrecedence

/// Excluding·assignment.
///
///  +  Version:
///     `0.2.0`.
infix operator ÷=: AssignmentPrecedence

/// Of.
///
///  +  Version:
///     `0.2.0`.
infix operator ×: TimesPrecedence

/// Zero·or·one·of.
///
///  +  Version:
///     `0.2.0`.
postfix operator ^?

/// One·of.
///
///  +  Version:
///     `0.2.0`.
postfix operator ^!

/// One·or·more·of.
///
///  +  Version:
///     `0.2.0`.
postfix operator ^+

/// Zero·or·more·of.
///
///  +  Version:
///     `0.2.0`.
postfix operator ^*
