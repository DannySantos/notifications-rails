module NotificationHandler
    class Group

        attr_accessor :name
        attr_accessor :target_scope

        def initialize name, target_scope
            @name = name
            @target_scope = target_scope
        end

        def self.find_by_name name
            NotificationHandler.configuration.groups.select { |group| group.name == name.to_sym }
        end

    end
end
