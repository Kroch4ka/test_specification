require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:json_body) { JSON.parse(response.body) }

  describe "POST /users" do
    subject(:action) { post "/users", params: }

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

    context "в случае неудачи" do
      let(:params) { super().merge({ age: 100 }) }

      it "возвращает 400 статус и информацию об ошибках" do
        action
        expect(response).to have_http_status :bad_request
        expect(json_body["errors"]).not_to be_empty
      end
    end

    it "отдаёт результат и 200 статус в случае успеха" do
      action
      expect(response).to have_http_status :ok
      expect(json_body.keys)
        .to contain_exactly("id", "name", "patronymic", "email", "age", "nationality", "country", "gender", "created_at", "updated_at")
    end
  end
end
