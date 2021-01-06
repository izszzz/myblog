FactoryBot.define do
    factory :account do
        email {Faker::Internet.email}
        password {"password"}
        password_confirmation {"password"}
        confirmed_at {Data.today}
    end
end