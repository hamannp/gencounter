defmodule Gencounter.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Gencounter.Producer, [0]),
      worker(Gencounter.ProducerConsumer, []),
      worker(Gencounter.Consumer, [], id: :a),
      worker(Gencounter.Consumer, [], id: :b),
      worker(Gencounter.Consumer, [], id: :c)
    ]

    opts = [strategy: :one_for_one, name: Gencounter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
