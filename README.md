# README

This application is the based on the sky bet technical test found here https://github.com/skybet/tech-test

# Ruby

The ruby version that will be used for this project is 2.3.1, in order to run this project it is recommended to have this version installed, but probably anything >= 2.0 will work. It can be installed using a version manager such as RVM. 

Once installed, the gems that this project will contain will need to be added as well, for that go into the console to the project's path and run
```
bundle install
```

After that all you need to run the application will be 
```
rails s
```

This will launch the application on the port 3000 on localhost. 

# Database

As for this project a database will not be used. It is required to store the data in text files. For this purpose I will extend Active Model to implement the model interfaces and use text files.  