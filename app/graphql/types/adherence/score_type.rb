# frozen_string_literal: true

class Types::Adherence::ScoreType < Types::BaseObject
  field :actual_injection, Int, null: false
  field :adherence_score, Int, null: false
  field :expected_injection, Int, null: false
  field :injections_graph, [Types::Adherence::InjectionGraphType], null: false
  field :on_time_injection, Int, null: false
end

