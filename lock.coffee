class Lock

    constructor: ->
        @_transactions = []

    start: ->
        transaction = new Transaction this
        @_transactions.push transaction
        transaction

    _transactionIsActive: (transaction) ->
        return transaction == @_transactions[0]

    _gotoNextTransaction: ->
        @_transactions[0..0] = []
        if @_transactions.length != 0
            @_transactions[0]._run()

class Transaction

    constructor: (@_lock) ->
        @_tasks = []
        @_finished = false

    exec: (task) ->
        if @_isActive()
            task()
        else
            @_tasks.push(task)

    finish: ->
        @_finished = true
        if @_isActive()
            @_gotoNextTransaction()

    _isActive: ->
        @_lock._transactionIsActive this

    _run: ->
        @_tasks.forEach (task) ->
            task()
        if @_finished
            @_gotoNextTransaction()

    _gotoNextTransaction: ->
        @_lock._gotoNextTransaction()

exports.Lock = Lock
