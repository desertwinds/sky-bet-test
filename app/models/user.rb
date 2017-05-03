class User
  include ActiveModel::Model
  include ActiveModel::Serialization
  extend ActiveModel::Callbacks
  define_model_callbacks :create, :update, :destroy

  attr_accessor :firstname, :surname, :id
  validates_presence_of [:firstname, :surname]

  def attributes
    {'id' => id,
      'firstname' => firstname,
      'surname' => surname}
  end

  def self.find(find_id)
    return nil unless find_id
    path = Rails.root.join('db', "#{find_id}.txt")
    if File.exist?(path)
      return get_user(path)
    else
      return nil
    end
  end

  def self.all
    @users = []
    @files = Dir[Rails.root.join('db', '*.txt')]
    @files.each do |path|
      @users << get_user(path)
    end
    return @users
  end

  def create
    run_callbacks :create do
      if valid?
        id = "#{firstname.parameterize.underscore}_#{surname.parameterize.underscore}_#{rand(10000)}"
        self.id = id
        filename = "#{id}.txt"
        path = Rails.root.join('db', filename)
        File.open(path, "w+") do |f|
          f.puts id
          f.puts firstname
          f.write(surname)
        end
        return true
      else
        return false
      end
    end
  end

  def update(params = {})
    run_callbacks :update do
      firstname = params[:firstname] if params[:firstname].present?
      surname = params[:surname] if params[:surname].present?
      if valid?
        filename = "#{id}.txt"
        path = Rails.root.join('db', filename)
        File.open(path, "w+") do |f|
          f.puts id
          f.puts firstname
          f.write(surname)
        end
        return true
      else
        return false
      end
    end
  end

  def destroy
    run_callbacks :destroy do
      path = Rails.root.join('db', "#{id}.txt")
      if File.exist?(path)
        return File.delete(path)
      else
        return false
      end
    end
  end

  def new_record?
    !id.present?
  end

  def persisted?
    id.present?
  end

  private

  def self.get_user(path)
    File.open(path, "r") do |f|
      @id = f.gets.chomp
      @firstname = f.gets.chomp
      @surname = f.gets
    end
    return User.new(id: @id, firstname: @firstname, surname: @surname)
  end

end