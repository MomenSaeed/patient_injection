# frozen_string_literal: true

class Types::Adherence::InjectionGraphType < Types::BaseObject
  field :date, GraphQL::Types::ISO8601Date, null: false
  field :day, Int, null: false
  field :expected_injection, Boolean, null: false
  field :has_injection, Boolean, null: false
  field :month, String, null: false
  field :week_day, String, null: false
  field :year, Int, null: false

  def day
    object[:date].day
  end

  def year
    object[:date].year
  end

  def week_day
    object[:date].strftime("%a")
  end

  def month
    object[:date].strftime("%b")
  end
end

