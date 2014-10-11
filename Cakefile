sys = require 'sys'
fs = require 'fs'
exec = require('child_process').exec
util = require 'util'

SRCDIR = './coffee'
OUTDIR = './js'
TARGET_FILENAME = 'mind-salver.js'

task 'hello', 'log sample text', ->
    console.log 'Hello World!'

task 'build', 'compile target files', ->
    exec "coffee --join #{OUTDIR}/#{TARGET_FILENAME} --compile #{SRCDIR}", (error, stdout, stderr) ->
        util.log(error) if error
        util.log(stdout) if stdout
        util.log(stderr) if stderr

        if error
            util.log('failed.')
        else
            util.log('successed.')

task 'clean', 'clean out build directory', ->
    targetFile = "#{OUTDIR}/#{TARGET_FILENAME}"
    fs.exists targetFile, (exists) ->
        if exists
            exec "rm #{targetFile}", (error) ->
                throw error if error
