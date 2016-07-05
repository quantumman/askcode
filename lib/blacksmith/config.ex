defmodule Blacksmith.Config do
  def save(_, data) do
    Askcode.Repo.insert(data)
  end

  def save_all(_, list) do
    Enum.map(list, &Askcode.Repo.insert/1)
  end
end
