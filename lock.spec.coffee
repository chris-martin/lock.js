Lock = require('./lock.coffee').Lock;

describe "Lock", ->

    it "executes callbacks that are given to it", ->

        lock = new Lock

        transaction = lock.start()

        a = ''

        transaction.exec -> a += '1'
        transaction.exec -> a += '2'

        expect(a).toBe('12')

    it "does not execute a second transaction if the first has not finished", ->

        lock = new Lock

        transaction_A = lock.start()
        transaction_B = lock.start()

        A = ''
        B = ''

        transaction_B.exec -> B += '1'
        transaction_A.exec -> A += '2'
        transaction_B.exec -> B += '3'
        transaction_A.exec -> A += '4'

        expect(B).toBe('')

    it "executes a second transaction after the first has finished", ->

        lock = new Lock

        transaction_A = lock.start()
        transaction_B = lock.start()

        A = ''
        B = ''

        transaction_B.exec -> B += '1'
        transaction_A.exec -> A += '2'
        transaction_B.exec -> B += '3'
        transaction_A.exec -> A += '4'
        transaction_A.finish()

        expect(B).toBe('13')
