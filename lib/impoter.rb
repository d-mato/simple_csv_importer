require 'csv'

module Importer
  def self.included(base)
    base.class_eval do
      @target_klass = base.to_s.sub(/Importer$/, '')
      @rules = []
      class << self
        attr_reader :rules, :target_klass
      end
    end
    base.extend ClassMethods
  end

  module ClassMethods
    def assign(attr_name, column_or_proc)
      unless attr_name.is_a? Symbol
        raise ArgumentError, 'attr_name must be a Symbol'
      end
      unless [Proc, String].include? column_or_proc.class
        raise ArgumentError, 'column_or_proc must be a Proc or String'
      end

      processor =
        if column_or_proc.is_a? String
          if block_given?
            ->(row) { yield row[column_or_proc] }
          else
            ->(row) { row[column_or_proc] }
          end
        elsif column_or_proc.is_a? Proc
          column_or_proc
        end
      @rules << [attr_name, processor]
    end
  end

  ### Instance Methods

  # @param [String] csv_text
  # @return [Array]
  def load(csv_text)
    csv = CSV.parse(csv_text, headers: true)

    target_class = Object.const_get(self.class.target_klass)
    csv.map do |row|
      target = target_class.new
      self.class.rules.each do |attr_name, processor|
        target.public_send(:"#{attr_name}=", processor.call(row))
      end
      target
    end
  end
end
