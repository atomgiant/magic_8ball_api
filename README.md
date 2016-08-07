
# Elixir Magic8ball API

## Overview

This repository contains a Magic8ball API written in Elixir.

This code is used to highlight elements of building APIs with Elixir using Plug as part of an Elixir talk given to the Triangle Elixir meetup.

See also: https://github.com/atomgiant/magic_8ball_phoenix

## Setup

1. Install the dependencies

  ```
  mix deps.get
  ```

1. Start the API app

  ```
  iex -S mix
  ```

1. Make a call to the API

  ```
  curl localhost:8080/api/shake
  ```

## API specs

* [API V1](API_V1.md)
* [API V2](API_V2.md)
