# [Julia Observer](https://juliaobserver.com)

A package browsing tool for:

[![julia](https://cloud.githubusercontent.com/assets/3156114/21341070/8bdee4a4-c658-11e6-9e9d-5e3cbdca8e8b.png)](http://julialang.org/)

-----

To get julia observer up and running locally, type these commands into the terminal:

+ `export ACCESS_TOKEN=__your_github_api_token__`
+ `git clone https://github.com/djsegal/julia_observer.git`
+ `cd julia_observer`
+ `bundle install`
+ `rake job:boot job:download`
+ `// wait an hour for github-api rate-limit to reset`
+ `rake job:expand job:update`
+ `// grab a coffee...`
+ `rails server`

If everything went ok, you can now visit [localhost:3000](http://localhost:3000/) in the browser

-----

#### notes:

+ `__your_github_api_token__` can be generated at [github.com](https://github.com/settings/tokens)
