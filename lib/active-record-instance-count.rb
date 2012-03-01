require "active-record-instance-count/version"
require "active-record-instance-count/utils/hash_utils"
require "active-record-instance-count/instrumentation"

module ActiveRecordInstanceCount
  class Middleware
    def initialize(app, options = {})
      @app         = app
      unless options[:logger]
        raise 'Missing options[:logger] argument'
      end
      @logger      = options[:logger]
      ActiveRecord::Base.send(:include, ActiveRecordInstanceCount::Instrumentation::ActiveRecord) 
    end

    def call(env)
      status, headers, body = @app.call(env)
      log_activerecord
      [status, headers, body]
    end

    def log_activerecord
      sorted_list = ActiveRecordInstanceCount::HashUtils.to_sorted_array(ActiveRecord::Base.instantiated_hash)
      sorted_list.unshift("Total: #{ActiveRecord::Base.total_objects_instantiated}")
      @logger.info("Instantiation Breakdown: #{sorted_list.join(' | ')}")
      reset_objects_instantiated
    end
    
    private
    
    def reset_objects_instantiated
      ActiveRecord::Base.reset_instance_type_count
    end
    
  end
end
