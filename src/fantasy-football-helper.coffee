# Description
#   Fantasy football help for your hubot
#
# Configuration:
#   none
#
# Commands:
#   hubot start [player one] or [player two] - fantasy football analysis>
#
# Dependencies:
#   scrapeit
#
# Author:
#   parksjr <mike@parksjr.tech>

_fpUrl = "http://www.fantasypros.com/nfl/start/PLAYER1-PLAYER2.php"
scrape = require('scrapeit')

module.exports = (robot) ->
	robot.respond /(?:should i )?start (.*) or (.*)(?:\?)?$/i, (msg) ->
		player1 = msg.match[1]
		player2 = msg.match[2]
		url = wsisUrl player1, player2
		scrape url, (err, o, dom) ->
			if err
				msg.send "There was an issue with the request. It has not been logged, and technical support is not working on itS. Please try again later, gator."
				console.log err
				return
			elmLeft = o 'div#picks div.wsis-summary div.player-left span'
			elmRight = o 'div#picks div.wsis-summary div.player-right span'
			# console.log elmLeft[0].children, elmRight[0]
			try
				# results
				leftpct = parseInt elmLeft[0].children[0].raw
				rightpct = parseInt elmRight[0].children[0].raw
				switch
					when leftpct > rightpct then msg.send "#{leftpct}% of expert analysis says you should start *#{player1}* over #{player2}"
					when rightpct > leftpct then msg.send "#{rightpct}% of expert analysis says you should start *#{player2}* over #{player1}"
					else msg.send "Experts are stuck on this one. #{leftpct}% say start #{player1}, #{rightpct} say start #{player2}"
			catch err
				msg.send "I don't recognize the players, check the spelling and try again."
			finally
				#	do nothing
				

wsisUrl = (leftPlayer, rightPlayer) ->
	_fpUrl.replace("PLAYER1", encode leftPlayer).replace("PLAYER2", encode rightPlayer)
encode = (name) ->
	name.toLowerCase().replace " ", "-"
