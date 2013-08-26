include FactoryGirl::Syntax::Methods

FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change
  # deleting fixtures files does not force a rebuild
  # We include the Setting model because adding a new setting will require a new setting record to be persisted for test
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb", "app/models/setting.rb"]

  # now declare objects
  fbuilder.factory do
    first = name(:intro, Post.create(title: 'Intro to object oriented INTERCAL', body: "Do you hate programming? You will, after this simple tutorial!", published: true))
  end
end
