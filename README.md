Exit\_0
=========

A simple method that raises Exit\_0::Non\_0 
if $?.exitstatus is not 0. 

Don't like Exit\_0? Try:

* [posix-spawn](https://github.com/rtomayko/posix-spawn).
That is the easiest way to handle child processes 
(aka shelling out). 
* [open4](https://github.com/ahoward/open4)
* [POpen4](https://github.com/shairontoledo/popen4)
* [Here are other alternatives](http://stackoverflow.com/questions/6338908/ruby-difference-between-exec-system-and-x-or-backticks).

Windows
------

Use something else. Check the previous list above
for other alternatives, 
especialy [POpen4](https://github.com/shairontoledo/popen4),
which is Windows and POSIX compatible.

Implementation
----

Exit\_0 runs your command through bash:

    Exit_0 "
      cd ~/
      pwd
    "

    # --> Your command is processed as:
    str = str.split("\n").map(:strip).map(&:reject).join('&&')
    "bash -lc #{str.inspect}"

Exit\_0 lives in one file. So if you have any questions, [here
it is](https://github.com/da99/Exit\_0/blob/master/lib/Exit\_0.rb).


Installation
------------

    gem install Exit_0

Usage
------

    require "Exit_0"
    
    Exit_0 'uptime'
    Exit_0 'ls', :input=>' /some/dir '
    Exit_0 { system "uptime" }
    
    # The following raises an error.
    Exit_0 'uptimeSS'
    Exit_0 { `uptimeSSS` }

    # Exit_0 and Exit_0 are the same.
    Exit_0 'uptime'
    Exit_0 'grep a', :input=>"a \n b \n c"

    # Get results from standard output, standard error.
    Exit_0('uptime').out      # String is stripped.
    Exit_0('uptimeSS').err    # String is stripped.
    
    Exit_0('uptime').raw_out  # Raw string, no :strip used.
    Exit_0('uptime').raw_err  # Raw string, no :strip used.
    
Run Tests
---------

    git clone git@github.com:da99/Exit_0.git
    cd Exit_0
    bundle update
    bundle exec bacon spec/main.rb

"I hate writing."
-----------------------------

If you know of existing software that makes the above redundant,
please tell me. The last thing I want to do is maintain code.


