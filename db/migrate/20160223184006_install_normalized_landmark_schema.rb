class InstallNormalizedLandmarkSchema < ActiveRecord::Migration
  def change

    # Core fields:

    add_column :landmarks, :opened, :integer
    add_column :landmarks, :opened_qualifier, :string

    add_column :landmarks, :closed, :integer
    add_column :landmarks, :closed_qualifier, :string

    add_column :landmarks, :location_qualifier, :string
    add_column :landmarks, :address_name, :string
    add_column :landmarks, :address_street, :string
    add_column :landmarks, :address_type, :string
    add_column :landmarks, :address_postal, :string
    add_column :landmarks, :priority, :integer
    add_column :landmarks, :kb_association, :string

    # Optional fields:

    add_column :landmarks, :also_known_as, :string
    add_column :landmarks, :category, :string
    add_column :landmarks, :notes, :string
    add_column :landmarks, :architect, :string
    add_column :landmarks, :artist, :string
    add_column :landmarks, :denomination, :string
    add_column :landmarks, :monument_type, :string
    add_column :landmarks, :physical_type, :string
    add_column :landmarks, :monument_subject, :string
    add_column :landmarks, :monument_sphere_1, :string
    add_column :landmarks, :monument_sphere_2, :string
    add_column :landmarks, :monument_sphere_3, :string
    add_column :landmarks, :monument_patronage, :string
    add_column :landmarks, :monument_legend, :string
    add_column :landmarks, :person_dates, :string
    add_column :landmarks, :research_questions, :string
    add_column :landmarks, :branch, :string
    add_column :landmarks, :kb_tag, :string
    add_column :landmarks, :kb_subtag, :string
    add_column :landmarks, :kb_extra_tag, :string
    add_column :landmarks, :court_type, :string
    add_column :landmarks, :railway_line, :string
    add_column :landmarks, :drama_category, :string

  end
end
