//  🖋🥑 Nib Core :: Nib·Core :: Precedences
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Exclusion precedence.
///
///  +  term Available since:
///     0·2.
precedencegroup ExclusionPrecedence {
	higherThan: MultiplicationPrecedence
	lowerThan: BitwiseShiftPrecedence
	associativity: none
}

/// Times precedence.
///
///  +  term Available since:
///     0·2.
precedencegroup TimesPrecedence {
	higherThan: CastingPrecedence
	lowerThan: RangeFormationPrecedence
	associativity: right
}
