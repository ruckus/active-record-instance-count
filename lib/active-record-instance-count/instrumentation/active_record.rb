module ActiveRecordInstanceCount

  def self.extended_active_record?
    @_extended_active_record
  end

  def self.extended_active_record!
    @_extended_active_record = true
  end

  module Instrumentation
    module ActiveRecord

      def self.included(klass)
        klass.class_eval do

          @@instantiated = {}
          @@total = nil

          def self.reset_instance_type_count
            @@instantiated = {}
            @@total = nil
          end

          def self.increment_instance_type_count
            @@instantiated[base_class.name] ||= 0
            @@instantiated[base_class.name] += 1
          end

          def self.instantiated_hash
            @@instantiated
          end

          def self.total_objects_instantiated
            @@total ||= @@instantiated.values.sum
          end

          unless ActiveRecordInstanceCount.extended_active_record?
            class << self
              alias_method :allocate_before_counter, :allocate

              def allocate
                value = allocate_before_counter
                increment_instance_type_count
                value
              end
            end

            alias_method :initialize_before_counter, :initialize

            def initialize(*args, &block)
              value = initialize_before_counter(*args, &block)
              self.class.increment_instance_type_count
              value
            end

            ActiveRecordInstanceCount.extended_active_record!
          end
        end
      end
    end
  end
end