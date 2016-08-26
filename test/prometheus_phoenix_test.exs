defmodule PrometheusPhoenixTest do
  use ExUnit.Case
  use Phoenix.ConnTest

  use Prometheus.Metric

  @endpoint PrometheusPhoenixTest.Endpoint

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "Qwe" do
    conn = get build_conn(), "/qwe"
    assert html_response(conn, 200) =~ "qwe"
    assert {buckets, sum} = Histogram.value([name: :phoenix_controller_call_duration_microseconds,
                                             labels: ["PrometheusPhoenixTest.Controller", :qwe]])
    assert sum > 0
    assert 1 = Enum.reduce(buckets, fn(x, acc) -> x + acc end)
  end
end
