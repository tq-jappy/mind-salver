sys = require 'sys'
fs = require 'fs'
exec = require('child_process').exec
util = require 'util'

COMMAND = 'coffee'
SRCDIRS = ['./coffee', './coffee/models', './coffee/views', './coffee/controllers']
OUTDIR = './js'
TARGET_FILENAME = 'mind-salver.js'
OPTIONS = "-wcb -j #{TARGET_FILENAME} -o #{OUTDIR}"

targetList = []
for dir in SRCDIRS
    for f in fs.readdirSync dir
        # util.log "--#{f}"
        targetList.push "#{dir}/#{f}" if f.match /^(\w+)\.coffee$/

task 'hello', 'log sample text', ->
    console.log 'Hello World!'

task 'build', 'compile target files', ->
    targetList = targetList.join(' ')
    util.log "targetList = #{targetList}"

    option = "#{OPTIONS} #{targetList}"
    util.log "start compile command: coffee #{option}"

    exec "coffee #{option}", (error, stdout, stderr) ->
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
    # if fs.readdirSync(OUTDIR).length > 0
    #     exec "rm #{OUTDIR}/*.js", (error) ->
    #         throw error if error
