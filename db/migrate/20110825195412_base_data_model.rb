class BaseDataModel < ActiveRecord::Migration
  def change  
    create_table :scenarios, :force => true do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :segments, :force => true do |t|
      t.timestamps
    end
    
    create_table :geo_points, :force => true do |t|
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.decimal :accuracy, :precision => 5, :scale => 2
      t.integer :data_source_id
      t.timestamps
    end
    add_index :geo_points, :data_source_id
    
    create_table :geo_point_on_segments, :force => true do |t|
      t.integer :geo_point_id
      t.integer :segment_id
      t.integer :project_id
    end
    add_index :geo_point_on_segments, :geo_point_id
    add_index :geo_point_on_segments, :segment_id
    add_index :geo_point_on_segments, :project_id
    
    create_table :data_sources, :force => true do |t|
      t.string :name
      t.string :kind
      t.timestamps
    end
    
    create_table :segment_in_scenarios, :force => true do |t|
      t.integer :scenario_id
      t.integer :segment_id
      t.string :status
      t.timestamps
    end
    add_index :segment_in_scenarios, :scenario_id
    add_index :segment_in_scenarios, :segment_id
    
    create_table :count_sessions, :force => true do |t|
      t.integer :segment_id
      t.datetime :start
      t.datetime :stop
      t.string :status
      t.timestamps
    end
    add_index :count_sessions, :segment_id
    
    create_table :counts, :force => true do |t|
      t.integer :count_session_id
      t.datetime :at
      t.timestamps
    end
    add_index :counts, :count_session_id
  end
end