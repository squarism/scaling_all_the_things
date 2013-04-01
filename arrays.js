/*
	LOL WTF can't even run the 100m test with node.js
	node --max-old-space-size=1900 arrays.js 100000000
	FATAL ERROR: JS Allocation failed - process out of memory

	Node has a 1gb limit.  With a flag, 1.7gb.  Yay?
*/


// a technique to get command line arguments
var arguments = process.argv.splice(2);
var num = arguments[0];

// do the test
var array = [];
var start = new Date();
for (var i=0; i < num; i++) {
	array.push(i);
}
var elapsed = new Date() - start;

// print the results
console.log("Done.  Array size is %s", numberWithCommas(array.length) );
console.log(secondsToString(elapsed / 1000));


// helpers
function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function secondsToString(seconds) {
	var numhours = Math.floor(((seconds % 31536000) % 86400) / 3600);
	var numminutes = Math.floor((((seconds % 31536000) % 86400) % 3600) / 60);
	var numseconds = Math.floor((((seconds % 31536000) % 86400) % 3600) % 60);
	var milliseconds = seconds * 1000 % 1000;
	return numhours + " hours, " + numminutes + " minutes, " + numseconds + " seconds, " + milliseconds + " ms";
}

/*
Done.  Array size is 1,000,000
0 hours, 0 minutes, 0 seconds, 177 ms

Done.  Array is 10,000,000
0 hours, 0 minutes, 2 seconds, 28 ms

Well that's the end of my tests because V8 has a max memory limit of 1GB.  1.7GB if
you configure some deprecated flag.
*/