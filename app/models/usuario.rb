class Usuario < ActiveRecord::Base
  attr_accessor :login
  
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]


  validates :username, presence: true, uniqueness: {case_sensitive: false},
  length: {in: 5..20, too_short: "Debe tener al menos 5 caracteres", too_long: "Debe tener menos de 20 caracteres"},
  format: {with: /([A-Za-z0-9\-\_]+)/, message: "Debe contener solo letras, numeros y guiones"}

  

  #para que funcione con facebook
  def self.find_or_create_by_omniauth(auth)
    usuario = Usuario.where(provider: auth[:provider], uid: auth[:uid]).first

    unless usuario
      usuario = Usuario.create(
        nombre: auth[:nombre],
        apellido: auth[:apellido],
        username: auth[:username],
        email: auth[:email],
        uid: auth[:uid],
        provider: auth[:provider],
        password: Devise.friendly_token[0,20]
        )
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

end
