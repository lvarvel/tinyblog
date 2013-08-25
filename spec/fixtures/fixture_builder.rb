include FactoryGirl::Syntax::Methods

FixtureBuilder.configure do |fbuilder|
  Sunspot.session = SunspotMatchers::SunspotSessionSpy.new(Sunspot.session)

  # rebuild fixtures automatically when these files change
  # deleting fixtures files does not force a rebuild
  # We include the Setting model because adding a new setting will require a new setting record to be persisted for test
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb", "app/models/setting.rb"]

  # now declare objects
  fbuilder.factory do
    maps_feature = name(:maps, Feature.create(name: 'maps', display_name: 'Maps'))
    name(:food_and_drink, Feature.create(name: 'food_and_drink', display_name: 'Food and Drink'))
    name(:help_center, Feature.create(name: 'help_center', display_name: 'Help Center'))

    name(:red, create(:account_level, name: "Red", threshold: 0))
    purple = name(:purple, create(:account_level, name: "Purple", threshold: 1000)).first
    name(:vibranium, create(:account_level, name: "Vibranium", threshold: 99999999)).first

    name(:admin, create(:administrator, email: 'first_admin@example.com'))

    name(:basic, create(:user, email: 'first_user@example.com', account_level_id: purple.id))
    name(:with_features, create(:user, email: 'featureful@example.com', features: maps_feature, account_level_id: purple.id))

    with_points = name(:with_points, create(:user, email: 'pointy@example.com', account_level_id: purple.id)).first
    with_points.update_points({amount: 9001, note: "From the fixture"})
    with_points.save

    #create app settings for spec with simple values
    Setting::SETTINGS.each do |name|
      Setting.create(name: name, value: name, display_name: name)
    end
  end
end
