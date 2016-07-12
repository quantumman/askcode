defmodule Forge do
  use Blacksmith

  @save_one_function &Blacksmith.Config.save/2
  @save_all_function &Blacksmith.Config.save_all/2

  register :discussion, %Askcode.Discussion{
    subject: Faker.App.name,
    description: Faker.Lorem.Shakespeare.hamlet,
    code: Faker.Lorem.sentence(%Range{first: 1, last: 10})
  }

  register :reply, %Askcode.Reply{
    description: Faker.Lorem.Shakespeare.hamlet,
    code: Faker.Lorem.sentence(%Range{first: 1, last: 10})
  }

  register :user, %Askcode.User{
    name: Faker.Internet.user_name,
    avatar: Faker.Avatar.image_url(64, 64),
    email: Faker.Internet.email,
    encrypted_password: Faker.Bitcoin.address
  }
end
