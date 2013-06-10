FactoryGirl.define do

  factory(:client) do
    sequence(:nick) { | n | "Client ##{n}" }
    password "letmein"
    password_confirmation "letmein"
    confirmed_at DateTime.new

    factory :client_with_projects do
      ignore { n_projects 1 }
      after(:create) do | client , evaluator |
        FactoryGirl.create_list(:project , evaluator.n_projects , { :client => client })
      end
    end

    factory(:admin) do
      sequence(:nick) { | n | "Admin ##{n}" }
      is_admin true
    end
  end

  factory(:project) do
    sequence(:name) { | n | "Project ##{n}" }
    association :client
  end

  factory(:event) do
    sequence(:tag) { | n | "Event ##{n}" }
    association :project
  end

  factory(:initiator) do
    sequence(:name) { | n | "Initiator #{n}" }
    kind USER_KIND
    association :event
  end

  factory(:trigger) do
    sequence(:name) { | n | "Trigger #{n}" }
    kind CLICK_KIND
    association :event
  end

  factory(:receiver) do
    sequence(:name) { | n | "Initiator #{n}" }
    kind OBJECT_KIND
    association :event
  end

  factory(:response) do
    sequence(:name) { | n | "Response #{n}" }
    kind SOUND_KIND
    association :event
  end
end
