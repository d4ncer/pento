defmodule Pento.Mailer do
  use Swoosh.Mailer,
    otp_app: :pento,
    adapters: Swoosh.Adapters.Local
end
