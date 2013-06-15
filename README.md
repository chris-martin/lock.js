***lock.js*** - My answer to http://stackoverflow.com/questions/17118060/to-lock-or-not-to-lock

> I have a JavaScript/jQuery web app that contains an object that is read/write
> accessed by the user via DOM events as well as by the server via web sockets or xhr.
>
> I know that JavaScript is single threaded. Nevertheless, I suspect that in this
> setting the object in question might be subject to race conditions, and I wonder how
> to deal with this in the absence of locks in JavaScript.

Well... I guess you could write a "lock" of sorts, if what you're saying is that multiple things
each need to have exclusive use of the object, where those uses span multiple events.
