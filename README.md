JDEE-live
=========

Introduction
------------

This is an early attempt to provide a backend server for JDEE -- the Java
Development Environment, build around a Clojure nrepl server.

JDEE already uses beanshell to provide a scriptable front-end to the JVM.
While the beanshell provides a Javaesque syntax, it is actually quite old and
not really developed. More over, interaction between Emacs and beanshell uses
a "internal process with parsing" approach to interaction.

JDEE-live instead uses Clojure which is a JVM hosted Lisp, with good JVM
interoperability facilities. It is well supported, is used within the Emacs
community (and the Clojure community widely uses Emacs!) and there is already
a lot of support for interaction between the two. JDEE-live uses the nREPL
protocol with a specialised syntax for communication to Emacs (and vice
versa), already supported by CIDER.

JDEE-live needs jdee-nrepl to be launched for communication. Currently, this
is done via Maven. Other techniques could be added (including "roll-your-own"
customisable for any application).

Build
-----

Build uses leiningen to build jdee-nrepl, maven to build the maven plugin, and
cask to build the Emacs package. jdee-sample is just for testing.


Status
------

Currently, this is a proof of principle. It is possible to get a REPL up.
Once we have some useful interaction (probably retrieving the classpath, or
running an "import" statement), development will stop here and the components
will be split up into subprojects of JDEE, assuming the developers on the
mailing list agree!
