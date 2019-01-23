# PA-IMS  
by Fengzhencheng Zeng

This is a simple CLI program to manage artists and music tracks. Use `ruby main.rb` under root directory to start.
Type `help` to find details of the commands.

Features:
* Tiered architecture. The business logic part and data access part are fully decoupled
* ActiveRecord-like model design which is easy to use
* Standalone configuration and dependency files which make it easy to substitute modules, configure directories and manage dependencies

Remarks:
* Avoid using @@ since it may go anywhere if used in the class instance method
* Class instance is called so because a class is actually an instance of the Class class
* An instance of Class class can also have instance variable and that's where the class instance variable is from
