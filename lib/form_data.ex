defmodule FormData do

  defstruct boundary: "",
            body: <<>>,
            completed: false

  def put(form_data = %FormData{}, name, value) do
  end

  def put(form_data = %FormData{completed: false}, name, value) do
  end
  
  def start() do
    data = %FormData{boundary: gen_boundary}
  end

  def complete(form_data = %FormData{completed: false}) do
    put_in(form_data.completed, true)
  end

  def heads(form_data = %FormData{completed: true}) do
    {}
  end

  def heads do
  end
  
  defp gen_boundary do
    :crypto.rand_bytes(8)
    |> Base.encode16
    |> (&("--------FormDataBoundary" <> &1)).()
  end
end

