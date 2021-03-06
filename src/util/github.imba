
# connection to github
var github = require 'octonode'
var ghclient = github.client('5010c35936b455b4ddefb47d44888ed41a59a2c9')
var ghrepo = ghclient.repo('somebee/imba.io')

var cache = {}

def format doc
	var json = JSON.stringify(doc) do |key,value|
		if key isa String and key.match(/(^|\_)url$/)
			return undefined
		return value
	JSON.parse(json)

export def issues opts = {}, &cb
	if cache:issues
		return cb(cache:issues)
	# issues should be synced and cached by the server instead
	ghrepo.issues(opts) do |err, body|
		console.log(arguments)
		body = format(body)
		cb(cache:issues = body)

export def issue nr, &cb
	if cache[nr]
		return cb(cache[nr])

	ghclient.issue('somebee/imba.io', nr).info do |err,info|
		info = format(info)
		info:md = APP.Markdown.render(info:body)[:body]
		cb(cache[nr] = info)

# export def gists id, &cb
# 	ghclient.gist.starred do |err,res|
# 		console.log 'result from starred gists',res
# 
# export def get-gist id, &cb
# 	var gists = ghclient.gist