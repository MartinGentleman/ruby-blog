class User

  def User.authenticate(name, password)
    if name == "Martin" && password == "Heslo"
      return self
    end
  end

end