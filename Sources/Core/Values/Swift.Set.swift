//  #  Core :: Swift.Set  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension Set {

	/// Makes a new `Set` with the same `Element`s as the provided `source`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0.2.0
	///
	///  +  Parameters:
	///      +  source:
	///         A `UniqueValueArray` of `Element`s.
	@inlinable
	public init (
		_ source: UniqueValueArray<Element>
	) { self.init(source.storage🐵) }

}
