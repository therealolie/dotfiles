#!/data/data/com.termux/files/usr/bin/node
const repl = require('repl');

let r = repl.start({
  ignoreUndefined: true,
});

r.context.__ = require('lodash');
r.context.fs = require('fs');
