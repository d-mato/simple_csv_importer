class UserImporter
  include Importer

  assign :email, 'Email'
  assign :name, ->(row) { "#{row['First Name']} #{row['Last Name']}" }
  assign :sex, 'Sex' do |sex|
    sexes = { 'Male' => 1, 'Female' => 2 }
    sexes[sex]
  end
  assign :age, 'Age', &:to_i
end
