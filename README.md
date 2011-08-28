Installation Notes
==================

You need to install the rxtx kernel module for any of the serial communication to work.

on Ubuntu/Debian & Derivatives:

apt-get install librxtx-java

TODOs
=====

This is my backlog:

 * Clear up logging, it's really verbose right now, and it shouldn't be.
 * Use serial port events, instead of polling. See http://embeddedfreak.wordpress.com/2008/08/12/serial-port-event-in-rxtx/
 * Implement 'history' messages. Not sure what I want to do with them yet, but you get a lot.