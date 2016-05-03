chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'fantasy-football-helper', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/fantasy-football-helper')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/(?:should i )?start (.*) or (.*)(?:\?)?$/i)

  # it 'registers a hear listener', ->
    # expect(@robot.hear).to.have.been.calledWith(/orly/)
