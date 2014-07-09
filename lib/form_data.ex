defmodule FormData do

  defstruct boundary: "",
            body: <<>>,
            completed: false
  
  def init() do
    %FormData{boundary: gen_boundary}
  end

  def put(form_data = %FormData{completed: false}, name, value) do
    form_data.body
    |> append("--#{form_data.boundary}\r\n")
    |> append("Content-Disposition: form-data; name=\"#{name}\"\r\n\r\n")
    |> append("#{value}\r\n")
    |> (&(%FormData{form_data| body: &1})).()
  end

  def put(_, _, _) do
    raise "This FormData has been completed already."
  end

  def put(form_data, name, data, file_name) do
    put(form_data, name, data, file_name, MIME.Types.path(file_name))
  end

  def put(form_data = %FormData{completed: false}, name, data, file_name, content_type) do
    form_data.body
    |> append("--#{form_data.boundary}\r\n")
    |> append("Content-Disposition: form-data; name=\"#{name}\"; filename=\"#{file_name}\"\r\n")
    |> append("Content-Type: #{content_type}\r\n\r\n")
    |> append("#{data}\r\n")
    |> (&(%FormData{form_data| body: &1})).()
  end

  def put(_, _, _, _, _) do
    raise "This FormData has been completed already."
  end

  def putFile(form_data, name, file_path) do
    putFile(form_data, name, file_path, MIME.Types.path(file_path))
  end

  def putFile(form_data, name, file_path, content_type) do
    put(form_data, name, File.read!(file_path), Path.basename(file_path), content_type)
  end

  def final(form_data = %FormData{completed: false}) do
    update_in(form_data.body, &(&1 <> "--#{form_data.boundary}--\r\n"))
    |> (&(%FormData{&1| completed: true})).()
  end

  def final(_) do
    raise "This FormData has been completed already."
  end

  def headers(form_data = %FormData{completed: true}) do
    %{
      "content-length" => byte_size(form_data.body),
      "content-type" => "multipart/form-data; boundary=#{form_data.boundary}"
    }
  end

  def headers(form_data = %FormData{}) do
    complete(form_data)
    |> headers
  end

  defp append(body, data) do
    body <> data
  end

  defp prepend(data, body) do
    body <> data
  end
  
  defp gen_boundary do
    :crypto.rand_bytes(8)
    |> Base.encode16
    |> prepend("--------FormDataBoundary")
  end
end

