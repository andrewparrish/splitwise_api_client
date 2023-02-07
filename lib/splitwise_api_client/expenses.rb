module SplitwiseApiClient
  module Expenses
    # from is who lent the money
    # to is who owes the money
    def create_debit(from:, to:, amount:, date:, description:)
      post("/create_expense", {}, format_debit_body(from, to, amount, date, description))
    end

    private

    def format_debit_body(from, to, amount, date = DateTime.now, description = "")
      halved = (amount / 2).round(2)
      {
        cost: amount.to_s,
        description: description,
        date: date.to_s,
        group_id: 0,
        currency_code: "USD",
        users__0__user_id: to,
        users__0__paid_share: "0",
        users__0__owed_share: halved.to_s,
        users__1__user_id: from,
        users__1__owed_share: (amount - halved).to_s,
        users__1__paid_share: amount.to_s
      }
    end
  end
end
