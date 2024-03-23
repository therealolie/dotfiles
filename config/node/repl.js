#!/data/data/com.termux/files/usr/bin/node
const repl = require('repl');
process.env.NODE_REPL_HISTORY ??= process.env.HOME +  "/.node_repl_history";

const _ = require('lodash');

function fromBase(arr,n) {
	return arr.length == 0
		? 0
		: arr[0]|0 + (n|0)*(fromBase(arr.slice(1),n)|0);
}
function toBase(x,n,length = 0) {
	let out = [];
	while(x!=0){ // not equals for negative bases
		out.push(x%n)
		x = Math.floor(x/n);
	}
	while(out.length < length || out.length == 0)
		out.push(0);
	return out;
}
for(let func of ["chunk"]) {
	Object.defineProperty(Array.prototype, func, {
		value : function (...a){
			return _[func](this, ...a);
		}
	})
}
//
let r = repl.start({
	ignoreUndefined: true,
});
r.setupHistory(process.env.HOME + "/.node_repl_history",()=>{})
r.context.__ = _;
r.context.fs = require('fs');
r.context.toBase = toBase;
r.context.fromBase = fromBase;
r.context.Array = Array;
r.context.base64 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~_"
// */
