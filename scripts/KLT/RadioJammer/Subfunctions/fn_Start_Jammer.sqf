params [["_object",objnull], ["_Power",0.1]];									//_object is the jamming device, _Power is for future if I wanna have a custom jamming value. Default is set to 0.1
	// jam radios
	player setVariable ["tf_sendingDistanceMultiplicator", _Power,true];
	//player setVariable ["tf_receivingDistanceMultiplicator", _Power, true];