require 'rails_helper'

RSpec.describe Users::Create do
  subject(:action) { described_class.run(params:) }

  let(:params) do
    {
      name: "example",
      patronymic: "example",
      email: "alexeev@gmail.com",
      nationality: "rus",
      country: "RU",
      gender: "male",
      age: 10,
      skills: "programming,programming,procrastination",
      interests: %w[computer_science gaming]
    }
  end

  context "когда данные не валидны" do
    let(:params) { super().merge(age: 100) }

    it "возвращает не валидный объект" do
      expect(action).not_to be_valid
    end

    it "не создаёт пользователя" do
      expect { action }.not_to change(User, :count)
    end
  end

  it "создаёт умения" do
    expect { action }.to change(Skill, :count).from(0).to(2)
  end

  it "создаёт интересы" do
    expect { action }.to change(Interest, :count).from(0).to(2)
  end

  it "создаёт пользователя" do
    expect { action }.to change(User, :count).from(0).to(1)
  end
end
