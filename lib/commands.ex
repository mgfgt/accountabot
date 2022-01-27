defmodule Commands do
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
            }
          ]
        }
      ]
    }
  end
end
