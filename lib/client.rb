class Client
	attr_reader(:description, :salon_id)

	define_method(:initialize) do |attributes|
      @description = attributes.fetch(:description)
      @salon_id = attributes.fetch(:salon_id)
    end
end