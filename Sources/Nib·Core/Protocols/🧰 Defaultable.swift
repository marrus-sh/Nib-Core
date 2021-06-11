//  🖋🥑 Nib Core :: Nib·Core :: 🧰 Defaultable
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which has a default, accessible through the ``default`` property.
///
///  >  Note:
///  >  ``Defaultable`` is intended as common infrastructure for use in conjunction with other protocols or types.
///  >  It does not make ``Defaultable`` parameters optional, or guarantee that ``Defaultable`` default parameters will use the same defaults as suggested by the ``default`` property.
///
///  +  term Available since:
///     0·1.
///
///
/// ###  Conformance  ###
///
/// To conform to the ``Defaultable`` protocol, a type must implement its ``default`` property.
public protocol Defaultable {

	/// The default for this type.
	///
	///  +  term Available since:
	///     0·1.
	static var `default`: Self
	{ get }

}
