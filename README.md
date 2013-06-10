# Blogel

Blogel is just a simple rails blog engine that's meant to drop a small blog with basical functionalities inside of a rails app, as a mountable engine.

## Caution

For now Blogel depends on Rails Admin gem, the blogel install generator will try

As a first push, it's not really meant to be used "as is" since it's now only fitting our purposes, but efforts will be made to make it as useful as it can be for others when it'll be ready.

And for sure, contributions are always welcome if it's useful to you !

## Usage

1. Add in your Gemfile

```ruby
  gem "ancestry"
  gem "blogel", :git => "git@github.com:xana68/blogel"
```

2. Launch the install generator and tell where to mount blogel !

```bash
	rails g blogel:install
```

3. You're setup !