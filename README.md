# SimpleCsvImporter

Convert CSV data to instances of model and import to database easily.

## Usage

1. prepare model class

```ruby
class User
  attr_accessor :email, :name, :sex, :age
end
```

2. create importer

```ruby
class UserImporter
  include SimpleCsvImporter

  assign :email, 'Email'
  assign :name, ->(row) { "#{row['First Name']} #{row['Last Name']}" }
  assign :sex, 'Sex' do |sex|
    sexes = { 'Male' => 1, 'Female' => 2 }
    sexes[sex]
  end
  assign :age, 'Age', &:to_i
end
```

3. load csv and convert to instances of the model

```ruby
importer = UserImporter.new
csv_text = <<-TEXT
Email,First Name,Last Name,Sex,Age,
alice@example.com,Alice,Abbot,Female,20
bob@mail.com,Bob,Brown,Male,25
TEXT

importer.load(csv_text)
# =>
#[
#  #<User:0x01 @age=20, @email="alice@example.com", @name="Alice Abbot", @sex=2>,
#  #<User:0x02 @age=25, @email="bob@mail.com", @name="Bob Brown", @sex=1>
#]
```
