FormData
========

Build a multipart/form-data form struct in Elixir.

I need `{ :mime, github: "dynamo/mime" }` as a dependency.


```elixir

form = FormData.init()
|> FormData.put("name", "Z. Jin")
|> FormData.put("age", 28)
|> FormData.put("file1", "//I pretend to a script file","script.js", "text/javascript")
|> FormData.putFile("file2", "../my_picture.png")
|> FormData.putFile("file3", "../my_file", "plain/text")
|> FormData.final()

IO.inspect form
IO.inspect FormData.headers(form)

```