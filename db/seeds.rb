User.destroy_all
Stock.destroy_all
Trade.destroy_all
Portfolio.destroy_all
BankAccount.destroy_all
StockRating.destroy_all
UserCashHolding.destroy_all


u1 = User.create(name: "Jason", age: 27, upgrade: false)

10.times do
    BankAccount.create(account_number:Faker::Bank.account_number ,iban: Faker::Bank.iban,name:Faker::Bank.name, rounting_number: Faker::Bank.routing_number, swift_bic: Faker::Bank.swift_bic,account_balance: Faker::Number.number(digits: 10))
end
