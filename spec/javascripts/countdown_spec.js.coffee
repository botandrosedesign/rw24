#= require spec_helper
#= require jquery
#= require countdown

describe 'countdown', ->
  describe 'before the race', ->
    fixture.set '''
      <countdown now="Wed, 30 Jul 2008 18:00:00 -0500" target="Wed, 30 Jul 2008 19:00:00 -0500">
        <waiting>Waiting...</waiting>
        <during>During!</during>
        <div id="readout"><days/>:<hours/>:<minutes/>:<seconds/></div>
      </countdown>
    '''

    beforeEach ->
        countdown.init()

    it 'displays the time remaing until the race starts', ->
        expect($('#readout').text()).toEqual('00:00:59:59')

    it 'displays the waiting element', ->
        expect($('waiting').is(":visible")).toBe(true)
        expect($('during').is(":visible")).toBe(false)

  describe 'during the race', ->
    fixture.set '''
      <countdown now="Wed, 30 Jul 2008 20:00:00 -0500" target="Wed, 30 Jul 2008 19:00:00 -0500">
        <waiting>Waiting...</waiting>
        <during>During!</during>
        <div id="readout"><days/>:<hours/>:<minutes/>:<seconds/></div>
      </countdown>
    '''

    beforeEach ->
        countdown.init()

    it 'displays the time remaining until the race ends', ->
        expect($('#readout').text()).toEqual('00:01:00:01')

    it 'displays the during element', ->
        expect($('during').is(":visible")).toBe(true)
        expect($('waiting').is(":visible")).toBe(false)

  describe 'after the race', ->
    fixture.set '''
      <countdown now="Wed, 31 Jul 2008 20:00:00 -0500" target="Wed, 30 Jul 2008 19:00:00 -0500">
        <waiting>Waiting...</waiting>
        <during>During!</during>
        <div id="readout"><days/>:<hours/>:<minutes/>:<seconds/></div>
      </countdown>
    '''

    beforeEach ->
        countdown.init()

    it 'displays the time remaing until the next race starts', ->
        expect($('#readout').text()).toEqual('363:22:59:59')

    it 'displays the waiting element', ->
        expect($('waiting').is(":visible")).toBe(true)
        expect($('during').is(":visible")).toBe(false)
