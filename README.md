UNIX
====

* Describe how to spawn a new process.
    * If for instance we're discussing the 'init' process, pid 1 at the start up, the kernel would start it.
    * Either way, child process or for example init, the kernel allocates various resources and gives CPU time.
    * At a low level system calls are used to request the kernel to execute a process.
    * A library call such as fork() is essentially going to behave the same, as this creates a separate process.
    * Most new processes are a combination of fork() + execve(), overwriting the process image with a specified file.
* Describe how a process scheduler can be implemented, including any algorithms and data structures you would use.
    * Essentially a scheduler would need to be able to allow the instructions for multiple processes to reach the CPU.
    * Data structures would most likely be interested in keeping a queue of processes and deciding which gets to execute.
    * Algorithms would most likely be interested in efficient use of resources and preventing resource lock.
* Why are system calls slow?
    * Most likely either due to blocking (IO, etc) or congestion (too many processes in the queue).

Algorithms
==========

* Implement the functions declared in quiz.h, and evaluate their runtime complexities in Big O notation.
    * Please see quiz.c, it contains the functions and comments for the Big O notation.

Databases
=========

1. Describe how indexing works, including any algorithms and data structures that can be used.
    * Indexing is basically the categorizing of data in fields that allow queries to find data rapdily.
    * The data structures involved usually involves sorting information, perhaps alphabetically.
    * Although other smarter algorithms that use hashes to categorize.
2. What is normalization?
    * Normalization is when data is separated so as to make updates less impactful to various components interacting with the system.
3. What are some situations in which denormalization is necessary?
    * In situations where pooling information together wouldn't have a negative affect.
    * In some cases most of the queries are searching for big chunks of information, so separating them adds complexity.
4. Explain the differences between INNER JOIN, FULL OUTER JOIN, and LEFT OUTER JOIN.

HTTP
====

1. What do status codes 2xx, 3xx, 4xx, and 5xx indicate?
    * 5xx indicates errors.
    * 4xx indicates resources that may be missing.
    * 3xx is usually redirection\relocation.
    * 2xx is usually means success.
2. What is the difference between GET, POST, PUT, PATCH, and DELETE?
    * GET is simply getting and sending information using a URI.
    * POST uses headers to send information to the server.
    * PUT updates a "resource".
    * PATCH is similar to PUT but allows batching the updates to resources.
    * DELETE requests the deletion of a "resource".
3. What is the difference between a session and a cookie?
    * Sessions are usually related to the TCP connection and rather temporary.
    * Cookies are essentially identification and authentication, they will identify or authenticate a browser to a site.

Ruby
====

1. When are Mixins preferred over inheritance, and vice versa?
    * Mixins are usually preferred when sharing methods between multiple classes.
    * Inheritance is usually for extending classes, extending the compartmentalization of information.
2. Implement a fibonacci calculator.
    * Please see fibonacci.rb
3. Refactor the following code:
    * Please see main.rb (please excuse the additions above and below the lines of hashes).

API Wrapper
===========

Please see api.rb, curl was used when testing.

    $ curl -X POST -H "Content-Type: application/json" -d '{ "amount": 100, "credit_card": { "number": "0123456789012345", "expiry": "2018-04-31" } }' http://127.0.0.1:4567
