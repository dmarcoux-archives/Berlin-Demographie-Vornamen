Sequel.migration do
    up do
        create_table(:names) do
            primary_key :id
            String :name, null: false, size: 40
            Integer :count, null: false
            String :gender, null: false, size: 1, fixed: true
            String :neighborhood, null: false, size: 30
        end
    end

    down do
        drop_table(:names)
    end
end
