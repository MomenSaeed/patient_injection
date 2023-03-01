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
    context.date.day
  end

  def year
    context.date.year
  end

  def week_day
    context.date.strftime("%a")
  end

  def month
    context.date.strftime("%b")
  end
end

