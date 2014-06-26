function makeShout() { // (1)
	var phrase = "Превед!"; // (2)
	var shout = function() {  // (3,4)
		console.log(phrase);
	};
	phrase = "Готово!"; // (5)
	return shout;
}
	shout = makeShout();
	shout();

