//  #  Core :: Fragment🙊  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A fragment of an `ExcludingExpression`, representing a single operation.
internal enum Fragment🙊 <Terminal>:
	Hashable
where Terminal : Atomic {

	/// A reference to a nonterminal value.
	case nonterminal (
		Symbol🙊<Terminal>
	)

	/// A reference to a terminal value.
	case terminal (
		Terminal
	)

	/// A fragment which never matches.
	case never

	/// A catenation of zero or more fragments.
	indirect case catenation (
		[Fragment🙊]
	)

	/// An alternation of zero or more fragments.
	indirect case alternation (
		[Fragment🙊]
	)

	/// An exclusion of a second fragment from a first.
	indirect case exclusion (
		Fragment🙊,
		Fragment🙊
	)

	/// Zero or one of a fragment.
	indirect case zeroOrOne (
		Fragment🙊
	)

	/// Zero or more of a fragment.
	indirect case zeroOrMore (
		Fragment🙊
	)

	/// One or more of a fragment.
	indirect case oneOrMore (
		Fragment🙊
	)

}
