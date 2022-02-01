defmodule Accountabot.Commands.Create do
  def register do
    %{
      name: "register",
      description: "Register a play",
      options: [
        %{
          name: "purchase",
          description: "Register a purchase you have made",
          type: 1,
          options: [
            %{
              name: "type",
              description: "Set the type of purchase: mint or secondary",
              type: 3,
              require: true,
              choices: [
                %{
                  name: "mint",
                  value: "mint"
                },
                %{
                  name: "secondary",
                  value: "secondary"
                }
              ]
            },
            %{
              name: "collection",
              description: "Opensea link",
              type: 3,
              require: true,
            },
            %{
              name: "transaction",
              description: "Enter the transaction hash of the trade (this will fetch the cost of the trade in eth)",
              type: 3,
              require: true,
            },
            %{
              name: "period",
              description: "Set the target period for this play.",
              type: 4,
              require: true,
              choices: [
                %{
                  name: "instant",
                  value: 1
                },
                %{
                  name: "short",
                  value: 7
                },
                %{
                  name: "medium",
                  value: 30
                },
                %{
                  name: "long",
                  value: 90
                },
                %{
                  name: "none",
                  value: 0
                }
              ]
            }
          ]
        },
        %{
          name: "prediction",
          description: "Register a prediction that you haven't purchased yourself",
          type: 1,
          options: [
            %{
              name: "type",
              description: "Set the type of prediction: mint or secondary",
              type: 3,
              require: true,
              choices: [
                %{
                  name: "mint",
                  value: "mint"
                },
                %{
                  name: "secondary",
                  value: "secondary"
                }
              ]
            },
            %{
              name: "amount",
              description: "Set the entry amount in eth",
              type: 3,
              require: true
            },
            %{
              name: "period",
              description: "Set the target period for this play.",
              type: 4,
              require: true,
              choices: [
                %{
                  name: "instant",
                  value: 1
                },
                %{
                  name: "short",
                  value: 7
                },
                %{
                  name: "medium",
                  value: 30
                },
                %{
                  name: "long",
                  value: 90
                },
                %{
                  name: "none",
                  value: 0
                }
              ]
            },
            %{
              name: "collection",
              description: "Opensea link (if available)",
              type: 3,
            }
          ]
        }
      ]
    }
  end
end

defmodule Accountabot.Commands.Response do
  alias Nostrum.Struct.Interaction

  @doc """
  Directs an interaction to the appropriate behaviour
  """
  @callback create(Interaction) :: {:ok} | {:error, %{}}
end

defmodule Accountabot.Commands.Register do
  @behaviour Accountabot.Commands.Response

  alias Nostrum.Api
  alias Nostrum.Struct.Guild.Member
  alias Nostrum.Struct.User

  def create(interaction) do
    case interaction.data.options do
      [%{name: "purchase"}] -> register_purchase(interaction)
      [%{name: "prediction"}] -> register_prediction(interaction)
    end
  end

  defp register_purchase(interaction) do
    member = %Member{user: %User{id: interaction.user.id}}

    [command] = interaction.data.options
    options = Enum.reduce(command.options, %{}, fn (x, acc) -> Map.put(acc, x.name, x) end)
    type = Map.get(options, "type")
    collection = Map.get(options, "collection")
    amount = Map.get(options, "amount")
    period = Map.get(options, "period")

    response = %{
      type: 4,
      data: %{
        content: "Purchase registered. \nUser: #{Member.mention(member)} \nType: #{type.value} \nCollection: #{collection.value} \nCost: #{amount.value} eth \nPeriod: #{period.value} day"
      }
    }
    Api.create_interaction_response(interaction, response)
  end

  defp register_prediction(interaction) do
    member = %Member{user: %User{id: interaction.user.id}}

    [command] = interaction.data.options
    options = Enum.reduce(command.options, %{}, fn (x, acc) -> Map.put(acc, x.name, x) end)
    type = Map.get(options, "type")
    collection = Map.get(options, "collection")
    amount = Map.get(options, "amount")
    period = Map.get(options, "period")

    collection_value = if collection, do: collection.value, else: ""

    response = %{
      type: 4,
      data: %{
        content: "Prediction registered. \nUser: #{Member.mention(member)} \nType: #{type.value} \nCollection: #{collection_value} \nCost: #{amount.value} eth \nPeriod: #{period.value} day"
      }
    }
    Api.create_interaction_response(interaction, response)
  end
end
